import 'package:example/super_markdown/core/theme/flow_chart_theme.dart';
import 'package:flutter/material.dart';

class FlowChartThemes {
  // 明亮主题
  static final light = FlowChartTheme(
    defaultNodeTheme: NodeTheme(
      borderColor: Colors.blue.shade300,
      textColor: Colors.black87,
      borderWidth: 1.5,
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.1),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    defaultEdgeTheme: EdgeTheme(
      color: Colors.blue.shade300,
      strokeWidth: 1.5,
      animated: true,
    ),
  );

  // 暗色主题
  static final dark = FlowChartTheme(
    backgroundColor: Colors.grey.shade900,
    defaultNodeTheme: NodeTheme(
      backgroundColor: Colors.grey.shade800,
      borderColor: Colors.blue.shade300,
      textColor: Colors.white,
      borderWidth: 1.5,
      shadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.3),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    defaultEdgeTheme: EdgeTheme(
      color: Colors.blue.shade300,
      strokeWidth: 1.5,
      animated: true,
    ),
  );

  // 彩色主题
  static final colorful = FlowChartTheme(
    defaultNodeTheme: NodeTheme(
      borderColor: Colors.purple,
      textColor: Colors.black87,
      borderWidth: 2,
      cornerRadius: 8,
      gradient: const LinearGradient(
        colors: [Colors.purple, Colors.blue],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      shadows: [
        BoxShadow(
          color: Colors.purple.withOpacity(0.2),
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    defaultEdgeTheme: const EdgeTheme(
      color: Colors.purple,
      animated: true,
      arrowSize: 8,
      gradient: LinearGradient(
        colors: [Colors.purple, Colors.blue],
      ),
      animationColors: [
        Colors.purple,
        Colors.blue,
        Colors.pink,
      ],
    ),
    nodeThemes: {
      'start': NodeTheme(
        backgroundColor: Colors.green.shade100,
        borderColor: Colors.green,
        gradient: LinearGradient(
          colors: [Colors.green.shade300, Colors.green.shade500],
        ),
      ),
      'end': NodeTheme(
        backgroundColor: Colors.red.shade100,
        borderColor: Colors.red,
        gradient: LinearGradient(
          colors: [Colors.red.shade300, Colors.red.shade500],
        ),
      ),
      'process': NodeTheme(
        backgroundColor: Colors.blue.shade100,
        gradient: LinearGradient(
          colors: [Colors.blue.shade300, Colors.blue.shade500],
        ),
      ),
    },
    edgeThemes: {
      'success': EdgeTheme(
        color: Colors.green,
        animated: true,
        animationColors: [
          Colors.green.shade300,
          Colors.green.shade500,
          Colors.green.shade700,
        ],
      ),
      'error': const EdgeTheme(
        color: Colors.red,
        dashLength: 8,
        dashGap: 4,
      ),
    },
  );

  // 简约主题
  static final minimal = FlowChartTheme(
    backgroundColor: Colors.grey.shade50,
    defaultNodeTheme: NodeTheme(
      borderColor: Colors.grey.shade300,
      textColor: Colors.grey.shade800,
      padding: 12,
      fontSize: 12,
      cornerRadius: 2,
    ),
    defaultEdgeTheme: EdgeTheme(
      color: Colors.grey.shade400,
      strokeWidth: 1,
      arrowSize: 4,
    ),
  );
}
