import 'dart:ui';

import 'package:flutter/material.dart';

class FlowChartTheme extends ThemeExtension<FlowChartTheme> {
  final Color backgroundColor;
  final NodeTheme defaultNodeTheme;
  final EdgeTheme defaultEdgeTheme;
  final Map<String, NodeTheme> nodeThemes;
  final Map<String, EdgeTheme> edgeThemes;
  final bool animated;

  const FlowChartTheme({
    this.backgroundColor = Colors.white,
    this.defaultNodeTheme = const NodeTheme(),
    this.defaultEdgeTheme = const EdgeTheme(),
    this.nodeThemes = const {},
    this.edgeThemes = const {},
    this.animated = true,
  });

  @override
  FlowChartTheme copyWith({
    Color? backgroundColor,
    NodeTheme? defaultNodeTheme,
    EdgeTheme? defaultEdgeTheme,
    Map<String, NodeTheme>? nodeThemes,
    Map<String, EdgeTheme>? edgeThemes,
    bool? animated,
  }) {
    return FlowChartTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      defaultNodeTheme: defaultNodeTheme ?? this.defaultNodeTheme,
      defaultEdgeTheme: defaultEdgeTheme ?? this.defaultEdgeTheme,
      nodeThemes: nodeThemes ?? this.nodeThemes,
      edgeThemes: edgeThemes ?? this.edgeThemes,
      animated: animated ?? this.animated,
    );
  }

  @override
  FlowChartTheme lerp(ThemeExtension<FlowChartTheme>? other, double t) {
    if (other is! FlowChartTheme) return this;
    return FlowChartTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      defaultNodeTheme: NodeTheme.lerp(defaultNodeTheme, other.defaultNodeTheme, t),
      defaultEdgeTheme: EdgeTheme.lerp(defaultEdgeTheme, other.defaultEdgeTheme, t),
      nodeThemes: nodeThemes,
      edgeThemes: edgeThemes,
      animated: t < 0.5 ? animated : other.animated,
    );
  }
}

class NodeTheme {
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;
  final double borderWidth;
  final double padding;
  final double fontSize;
  final FontWeight fontWeight;
  final double cornerRadius;
  final List<BoxShadow>? shadows;
  final Gradient? gradient;

  const NodeTheme({
    this.backgroundColor = Colors.white,
    this.borderColor = Colors.blue,
    this.textColor = Colors.black,
    this.borderWidth = 1.0,
    this.padding = 16.0,
    this.fontSize = 14.0,
    this.fontWeight = FontWeight.normal,
    this.cornerRadius = 4.0,
    this.shadows,
    this.gradient,
  });

  static NodeTheme lerp(NodeTheme a, NodeTheme b, double t) {
    return NodeTheme(
      backgroundColor: Color.lerp(a.backgroundColor, b.backgroundColor, t)!,
      borderColor: Color.lerp(a.borderColor, b.borderColor, t)!,
      textColor: Color.lerp(a.textColor, b.textColor, t)!,
      borderWidth: lerpDouble(a.borderWidth, b.borderWidth, t)!,
      padding: lerpDouble(a.padding, b.padding, t)!,
      fontSize: lerpDouble(a.fontSize, b.fontSize, t)!,
      fontWeight: FontWeight.lerp(a.fontWeight, b.fontWeight, t)!,
      cornerRadius: lerpDouble(a.cornerRadius, b.cornerRadius, t)!,
      shadows: t < 0.5 ? a.shadows : b.shadows,
      gradient: t < 0.5 ? a.gradient : b.gradient,
    );
  }
}

class EdgeTheme {
  final Color color;
  final double strokeWidth;
  final PaintingStyle style;
  final bool animated;
  final double arrowSize;
  final double dashLength;
  final double dashGap;
  final Gradient? gradient;
  final StrokeCap strokeCap;
  final List<Color>? animationColors;

  const EdgeTheme({
    this.color = Colors.blue,
    this.strokeWidth = 2.0,
    this.style = PaintingStyle.stroke,
    this.animated = false,
    this.arrowSize = 6.0,
    this.dashLength = 5.0,
    this.dashGap = 5.0,
    this.gradient,
    this.strokeCap = StrokeCap.round,
    this.animationColors,
  });

  static EdgeTheme lerp(EdgeTheme a, EdgeTheme b, double t) {
    return EdgeTheme(
      color: Color.lerp(a.color, b.color, t)!,
      strokeWidth: lerpDouble(a.strokeWidth, b.strokeWidth, t)!,
      style: t < 0.5 ? a.style : b.style,
      animated: t < 0.5 ? a.animated : b.animated,
      arrowSize: lerpDouble(a.arrowSize, b.arrowSize, t)!,
      dashLength: lerpDouble(a.dashLength, b.dashLength, t)!,
      dashGap: lerpDouble(a.dashGap, b.dashGap, t)!,
      gradient: t < 0.5 ? a.gradient : b.gradient,
      strokeCap: t < 0.5 ? a.strokeCap : b.strokeCap,
      animationColors: t < 0.5 ? a.animationColors : b.animationColors,
    );
  }
} 