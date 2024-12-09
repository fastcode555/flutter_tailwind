import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class AutoCompleteOverlay extends StatelessWidget {
  final List<String> suggestions;
  final ValueChanged<String> onSelected;
  final VoidCallback onDismiss;
  final Offset position;
  final int selectedIndex;

  const AutoCompleteOverlay({
    required this.suggestions,
    required this.onSelected,
    required this.onDismiss,
    required this.position,
    required this.selectedIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Material(
        elevation: 8,
        borderRadius: BorderRadius.circular(8),
        child: container.white.rounded8.w200.maxH(26.0 * 6).child(
          ListView.builder(
            itemCount: suggestions.length,
            itemExtent: 26.0,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => _buildSuggestionItem(
              suggestions[index],
              isSelected: index == selectedIndex,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuggestionItem(String suggestion, {required bool isSelected}) {
    return container.p8
        .color(isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100])
        .child(
      row.children([
        // 图标
        _getIcon(suggestion).icon.color(isSelected ? Colors.blue : Colors.grey[600]).s16.mk,
        w8,
        // 文本
        Expanded(
          child: suggestion.text.color(isSelected ? Colors.blue : Colors.black).f14.mk,
        ),
        // 快捷键提示
        if (_getShortcut(suggestion) != null)
          _getShortcut(suggestion)!.text.color(isSelected ? Colors.blue : Colors.grey[400]).f12.mk,
      ]),
    ).click(onTap: () {
      onSelected(suggestion);
      onDismiss();
    });
  }

  IconData _getIcon(String suggestion) {
    if (functions.contains(suggestion)) {
      return Icons.functions;
    } else if (variables.contains(suggestion)) {
      return Icons.data_usage;
    } else if (units.contains(suggestion)) {
      return Icons.straighten;
    }
    return Icons.text_fields;
  }

  static final Set<String> functions = {
    // 三角函数
    'sin', 'cos', 'tan', 'asin', 'acos', 'atan',
    'sinh', 'cosh', 'tanh', 'asinh', 'acosh', 'atanh',
    // 数学函数
    'exp', 'log', 'log10', 'log2', 'sqrt', 'cbrt',
    'pow2', 'pow3', 'abs', 'ceil', 'floor', 'round',
    'trunc', 'rad', 'deg',
  };

  static final Set<String> variables = {
    // 常量
    'pi', 'e', 'phi',
    // 特殊变量
    'ans', 'prev', 'last',
    // 自定义变量示例
    'x', 'y', 'z', 'result',
  };

  static final Set<String> units = {
    // 长度
    'm', 'km', 'cm', 'mm', 'in', 'ft', 'mi',
    // 重量
    'kg', 'g', 'mg', 'lb', 'oz', 't',
    // 体积
    'l', 'ml', 'gal', 'qt', 'm3',
    // 面积
    'm2', 'km2', 'ha', 'acre', 'sqft',
    // 温度
    'c', 'f', 'k',
    // 时间
    's', 'min', 'h', 'day', 'week', 'month', 'year',
    // 速度
    'mps', 'kph', 'mph', 'knot',
    // 压力
    'pa', 'kpa', 'bar', 'psi', 'atm',
    // 能量
    'j', 'kj', 'cal', 'kcal', 'wh', 'kwh',
  };

  String? _getShortcut(String suggestion) {
    final shortcuts = {
      'sin': 'sin(',
      'cos': 'cos(',
      'tan': 'tan(',
      'sqrt': '√',
      'pow2': '²',
      'pow3': '³',
      'pi': 'π',
      'deg': '°',
    };
    return shortcuts[suggestion];
  }

  String _getDescription(String suggestion) {
    final descriptions = {
      'sin': '正弦函数',
      'cos': '余弦函数',
      'tan': '正切函数',
      'log': '自然对数',
      'sqrt': '平方根',
      'pow2': '平方',
      'pow3': '立方',
      'abs': '绝对值',
      'pi': '圆周率',
      'e': '自然常数',
      // ... 添加更多描述
    };
    return descriptions[suggestion] ?? '';
  }
} 