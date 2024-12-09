import 'package:example/super_markdown/core/theme/flow_chart_theme.dart';
import 'package:example/super_markdown/core/theme/flow_chart_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:graphview/GraphView.dart';

class FlowChart extends StatefulWidget {
  final String code;
  final FlowChartTheme? theme;

  const FlowChart({
    required this.code, super.key,
    this.theme,
  });

  @override
  State<FlowChart> createState() => _FlowChartState();
}

class _FlowChartState extends State<FlowChart> with SingleTickerProviderStateMixin {
  late final Graph graph;
  late final Algorithm algorithm;
  final Map<String, Node> nodes = {};
  final Map<String, NodeShape> shapes = {};
  final Map<String, NodeTheme> styles = {};
  late final AnimationController _controller;
  late final Animation<double> _animation;
  double _scale = 1;
  Offset _position = Offset.zero;

  @override
  void initState() {
    super.initState();
    graph = Graph();
    algorithm = FruchtermanReingoldAlgorithm();

    // 动画控制器
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _parseFlowChart(widget.code);
    _controller.forward();
  }

  void _parseFlowChart(String code) {
    final lines = code.split('\n');
    for (final line in lines) {
      if (line.trim().isEmpty) continue;

      // 解析节点定义: [id: label (shape) {style}]
      final nodeMatch = RegExp(r'\[([\w\d]+):\s*([^\]\(\{]+)(?:\s*\((\w+)\))?(?:\s*\{([^\}]+)\})?\]').firstMatch(line);
      if (nodeMatch != null) {
        final id = nodeMatch.group(1)!;
        final label = nodeMatch.group(2)!;
        final shape = nodeMatch.group(3);
        final style = nodeMatch.group(4);

        nodes[id] = Node.Id(id);
        shapes[id] = _parseShape(shape);
        styles[id] = _parseStyle(style);
        graph.addNode(nodes[id]!);
        continue;
      }

      // 解析连接: id1 -> id2: label {style}
      final edgeMatch = RegExp(r'([\w\d]+)\s*->\s*([\w\d]+)(?::\s*([^\{\n]+))?(?:\s*\{([^\}]+)\})?').firstMatch(line);
      if (edgeMatch != null) {
        final fromId = edgeMatch.group(1)!;
        final toId = edgeMatch.group(2)!;
        final label = edgeMatch.group(3);
        final style = edgeMatch.group(4);

        if (nodes.containsKey(fromId) && nodes.containsKey(toId)) {
          final edgeStyle = _parseEdgeStyle(style);
          graph.addEdge(
            nodes[fromId]!,
            nodes[toId]!,
            paint: Paint()
              ..color = edgeStyle.color
              ..strokeWidth = edgeStyle.strokeWidth
              ..style = edgeStyle.style,
          );
        }
      }
    }
  }

  NodeShape _parseShape(String? shape) {
    switch (shape?.toLowerCase()) {
      case 'diamond':
        return NodeShape.diamond;
      case 'circle':
        return NodeShape.circle;
      case 'hexagon':
        return NodeShape.hexagon;
      case 'cloud':
        return NodeShape.cloud;
      case 'database':
        return NodeShape.database;
      case 'document':
        return NodeShape.document;
      default:
        return NodeShape.rectangle;
    }
  }

  NodeTheme _getNodeTheme(String id) {
    final theme = widget.theme ?? FlowChartThemes.light;
    return theme.nodeThemes[id] ?? theme.defaultNodeTheme;
  }

  EdgeTheme _getEdgeTheme(String type) {
    final theme = widget.theme ?? FlowChartThemes.light;
    return theme.edgeThemes[type] ?? theme.defaultEdgeTheme;
  }

  @override
  Widget build(BuildContext context) {
    final theme = widget.theme ?? FlowChartThemes.light;
    return container.color(theme.backgroundColor).rounded8.p16.cardShadow.child(
          Stack(
            children: [
              // 图表区域
              GestureDetector(
                onScaleStart: (details) {
                  _position = details.focalPoint;
                },
                onScaleUpdate: (details) {
                  setState(() {
                    _scale *= details.scale;
                    _position = details.focalPoint;
                  });
                },
                child: InteractiveViewer(
                  boundaryMargin: const EdgeInsets.all(100),
                  minScale: 0.1,
                  maxScale: 5,
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _animation.value,
                        child: GraphView(
                          graph: graph,
                          algorithm: algorithm,
                          paint: Paint()
                            ..color = Colors.blue
                            ..strokeWidth = 2
                            ..style = PaintingStyle.stroke,
                          builder: _buildNode,
                        ),
                      );
                    },
                  ),
                ),
              ),

              // 工具栏
              Positioned(
                top: 8,
                right: 8,
                child: row.children([
                  // 导出按钮
                  IconButton(
                    icon: Icons.save.icon.grey600.s20.mk,
                    tooltip: '导出图片',
                    onPressed: _exportImage,
                  ),
                  // 重置缩放按钮
                  IconButton(
                    icon: Icons.refresh.icon.grey600.s20.mk,
                    tooltip: '重置缩放',
                    onPressed: () {
                      setState(() {
                        _scale = 1.0;
                        _position = Offset.zero;
                      });
                    },
                  ),
                ]),
              ),
            ],
          ),
        );
  }

  Widget _buildNode(Node node) {
    final id = node.key?.value as String?;
    if (id == null) return const SizedBox();

    final shape = shapes[id] ?? NodeShape.rectangle;
    final theme = _getNodeTheme(id);

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          padding: EdgeInsets.all(theme.padding),
          decoration: _buildNodeDecoration(shape, theme),
          child: Text(
            id,
            style: TextStyle(
              color: theme.textColor,
              fontSize: theme.fontSize,
              fontWeight: theme.fontWeight,
            ),
          ),
        );
      },
    );
  }

  BoxDecoration _buildNodeDecoration(NodeShape shape, NodeTheme theme) {
    switch (shape) {
      case NodeShape.circle:
        return BoxDecoration(
          color: theme.backgroundColor,
          shape: BoxShape.circle,
          border: Border.all(
            color: theme.borderColor,
            width: theme.borderWidth,
          ),
        );
      case NodeShape.diamond:
        return BoxDecoration(
          color: theme.backgroundColor,
          border: Border.all(
            color: theme.borderColor,
            width: theme.borderWidth,
          ),
          borderRadius: BorderRadius.circular(4),
        );
      // ... 添加更多形状的装饰
      default:
        return BoxDecoration(
          color: theme.backgroundColor,
          border: Border.all(
            color: theme.borderColor,
            width: theme.borderWidth,
          ),
          borderRadius: BorderRadius.circular(4),
        );
    }
  }

  Future<void> _exportImage() async {
    // TODO: 实现图片导出
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // 解析节点样式
  NodeTheme _parseStyle(String? style) {
    if (style == null) return _getNodeTheme('default');

    final theme = widget.theme ?? FlowChartThemes.light;
    final defaultTheme = theme.defaultNodeTheme;
    
    final styleMap = <String, dynamic>{};
    final pairs = style.split(',');
    
    for (final pair in pairs) {
      final parts = pair.trim().split(':');
      if (parts.length == 2) {
        final key = parts[0].trim();
        final value = parts[1].trim();
        styleMap[key] = value;
      }
    }

    return NodeTheme(
      backgroundColor: _parseColor(styleMap['bg']) ?? defaultTheme.backgroundColor,
      borderColor: _parseColor(styleMap['border']) ?? defaultTheme.borderColor,
      textColor: _parseColor(styleMap['text']) ?? defaultTheme.textColor,
      borderWidth: _parseDouble(styleMap['width']) ?? defaultTheme.borderWidth,
      padding: _parseDouble(styleMap['padding']) ?? defaultTheme.padding,
      fontSize: _parseDouble(styleMap['size']) ?? defaultTheme.fontSize,
      fontWeight: _parseFontWeight(styleMap['weight']) ?? defaultTheme.fontWeight,
      cornerRadius: _parseDouble(styleMap['radius']) ?? defaultTheme.cornerRadius,
      shadows: _parseShadows(styleMap['shadow']) ?? defaultTheme.shadows,
      gradient: _parseGradient(styleMap['gradient']) ?? defaultTheme.gradient,
    );
  }

  // 解析边线样式
  EdgeTheme _parseEdgeStyle(String? style) {
    if (style == null) return _getEdgeTheme('default');

    final theme = widget.theme ?? FlowChartThemes.light;
    final defaultTheme = theme.defaultEdgeTheme;
    
    final styleMap = <String, dynamic>{};
    final pairs = style.split(',');
    
    for (final pair in pairs) {
      final parts = pair.trim().split(':');
      if (parts.length == 2) {
        final key = parts[0].trim();
        final value = parts[1].trim();
        styleMap[key] = value;
      }
    }

    return EdgeTheme(
      color: _parseColor(styleMap['color']) ?? defaultTheme.color,
      strokeWidth: _parseDouble(styleMap['width']) ?? defaultTheme.strokeWidth,
      style: _parsePaintingStyle(styleMap['style']) ?? defaultTheme.style,
      animated: _parseBool(styleMap['animated']) ?? defaultTheme.animated,
      arrowSize: _parseDouble(styleMap['arrow']) ?? defaultTheme.arrowSize,
      dashLength: _parseDouble(styleMap['dash']) ?? defaultTheme.dashLength,
      dashGap: _parseDouble(styleMap['gap']) ?? defaultTheme.dashGap,
      strokeCap: _parseStrokeCap(styleMap['cap']) ?? defaultTheme.strokeCap,
      gradient: _parseGradient(styleMap['gradient']) ?? defaultTheme.gradient,
      animationColors: _parseColors(styleMap['animation']) ?? defaultTheme.animationColors,
    );
  }

  // 辅助解析方法
  Color? _parseColor(String? value) {
    if (value == null) return null;
    if (value.startsWith('#')) {
      return Color(int.parse(value.substring(1), radix: 16) + 0xFF000000);
    }
    switch (value.toLowerCase()) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'orange': return Colors.orange;
      case 'purple': return Colors.purple;
      case 'grey': return Colors.grey;
      case 'black': return Colors.black;
      case 'white': return Colors.white;
      default: return null;
    }
  }

  double? _parseDouble(String? value) {
    if (value == null) return null;
    return double.tryParse(value);
  }

  FontWeight? _parseFontWeight(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'bold': return FontWeight.bold;
      case 'normal': return FontWeight.normal;
      case 'light': return FontWeight.w300;
      default: return null;
    }
  }

  List<BoxShadow>? _parseShadows(String? value) {
    if (value == null) return null;
    final parts = value.split('|');
    return parts.map((part) {
      final values = part.split(' ');
      return BoxShadow(
        color: _parseColor(values[0]) ?? Colors.black26,
        blurRadius: _parseDouble(values[1]) ?? 4,
        spreadRadius: _parseDouble(values[2]) ?? 0,
        offset: Offset(
          _parseDouble(values[3]) ?? 0,
          _parseDouble(values[4]) ?? 0,
        ),
      );
    }).toList();
  }

  Gradient? _parseGradient(String? value) {
    if (value == null) return null;
    final parts = value.split('|');
    if (parts.length < 2) return null;

    final colors = parts[0].split(' ').map(_parseColor).whereType<Color>().toList();
    final stops = parts[1].split(' ').map(_parseDouble).whereType<double>().toList();

    return LinearGradient(
      colors: colors,
      stops: stops.length == colors.length ? stops : null,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  PaintingStyle? _parsePaintingStyle(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'fill': return PaintingStyle.fill;
      case 'stroke': return PaintingStyle.stroke;
      default: return null;
    }
  }

  StrokeCap? _parseStrokeCap(String? value) {
    if (value == null) return null;
    switch (value.toLowerCase()) {
      case 'butt': return StrokeCap.butt;
      case 'round': return StrokeCap.round;
      case 'square': return StrokeCap.square;
      default: return null;
    }
  }

  bool? _parseBool(String? value) {
    if (value == null) return null;
    return value.toLowerCase() == 'true';
  }

  List<Color>? _parseColors(String? value) {
    if (value == null) return null;
    return value.split(' ').map(_parseColor).whereType<Color>().toList();
  }
}

enum NodeShape {
  rectangle,
  diamond,
  circle,
  hexagon,
  cloud,
  database,
  document,
  parallelogram,
  cylinder,
  note,
}

class NodeStyle {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;
  final double padding;
  final double fontSize;

  const NodeStyle({
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blue,
    this.textColor = Colors.black,
    this.borderWidth = 1.0,
    this.padding = 16.0,
    this.fontSize = 14.0,
  });
}

class EdgeStyle {
  final Color color;
  final double strokeWidth;
  final PaintingStyle style;
  final bool animated;

  const EdgeStyle({
    this.color = Colors.blue,
    this.strokeWidth = 2.0,
    this.style = PaintingStyle.stroke,
    this.animated = false,
  });
}

class FlowChartStyle {
  final Color backgroundColor;
  final NodeStyle defaultNodeStyle;
  final EdgeStyle defaultEdgeStyle;
  final bool animated;

  const FlowChartStyle({
    this.backgroundColor = Colors.white,
    this.defaultNodeStyle = const NodeStyle(),
    this.defaultEdgeStyle = const EdgeStyle(),
    this.animated = true,
  });
}
