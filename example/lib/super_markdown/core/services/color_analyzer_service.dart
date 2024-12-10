import 'dart:math' as math;

import 'package:flutter/material.dart';

class ColorAnalyzerService {
  // 颜色分析
  static ColorAnalysis analyzeColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    final hsv = HSVColor.fromColor(color);
    final brightness = color.computeLuminance();

    return ColorAnalysis(
      hsl: hsl,
      hsv: hsv,
      brightness: brightness,
      isLight: brightness > 0.5,
      isDark: brightness < 0.5,
      isVivid: hsv.saturation > 0.7 && hsv.value > 0.7,
      isPastel: hsv.saturation < 0.3 && hsv.value > 0.9,
      isNeutral: hsv.saturation < 0.1,
      temperature: _calculateColorTemperature(color),
      contrastRatio: _calculateContrastRatio(color, Colors.white),
      accessibility: _analyzeAccessibility(color),
    );
  }

  // 颜色调和
  static ColorHarmony generateHarmony(Color baseColor) {
    final hsl = HSLColor.fromColor(baseColor);

    return ColorHarmony(
      base: baseColor,
      complementary: _rotateHue(hsl, 180).toColor(),
      analogous: [
        _rotateHue(hsl, -30).toColor(),
        _rotateHue(hsl, 30).toColor(),
      ],
      triadic: [
        _rotateHue(hsl, 120).toColor(),
        _rotateHue(hsl, 240).toColor(),
      ],
      tetradic: [
        _rotateHue(hsl, 90).toColor(),
        _rotateHue(hsl, 180).toColor(),
        _rotateHue(hsl, 270).toColor(),
      ],
      split: [
        _rotateHue(hsl, 150).toColor(),
        _rotateHue(hsl, 210).toColor(),
      ],
      monochromatic: _generateMonochromatic(hsl),
    );
  }

  // 颜色混合
  static Color blendColors(Color color1, Color color2, BlendMode mode) {
    switch (mode) {
      case BlendMode.multiply:
        return Color.fromARGB(
          255,
          (color1.red * color2.red) ~/ 255,
          (color1.green * color2.green) ~/ 255,
          (color1.blue * color2.blue) ~/ 255,
        );
      case BlendMode.screen:
        return Color.fromARGB(
          255,
          255 - ((255 - color1.red) * (255 - color2.red)) ~/ 255,
          255 - ((255 - color1.green) * (255 - color2.green)) ~/ 255,
          255 - ((255 - color1.blue) * (255 - color2.blue)) ~/ 255,
        );
      case BlendMode.overlay:
        return Color.fromARGB(
          255,
          _overlayChannel(color1.red, color2.red),
          _overlayChannel(color1.green, color2.green),
          _overlayChannel(color1.blue, color2.blue),
        );
      default:
        return color1;
    }
  }

  // 辅助方法
  static HSLColor _rotateHue(HSLColor color, double degrees) {
    return color.withHue((color.hue + degrees) % 360);
  }

  static List<Color> _generateMonochromatic(HSLColor base) {
    return List.generate(5, (i) {
      final lightness = (base.lightness + (i - 2) * 0.1).clamp(0.0, 1.0);
      return base.withLightness(lightness).toColor();
    });
  }

  static int _overlayChannel(int a, int b) {
    if (a < 128) {
      return (2 * a * b) ~/ 255;
    } else {
      return 255 - (2 * (255 - a) * (255 - b)) ~/ 255;
    }
  }

  static double _calculateColorTemperature(Color color) {
    // 简化的色温计算
    final r = color.red / 255;
    final b = color.blue / 255;
    return (b > 0 ? r / b : r) * 100;
  }

  static double _calculateContrastRatio(Color fg, Color bg) {
    final l1 = fg.computeLuminance();
    final l2 = bg.computeLuminance();
    final double lighter = math.max(l1, l2);
    final double darker = math.min(l1, l2);
    return (lighter + 0.05) / (darker + 0.05);
  }

  static AccessibilityInfo _analyzeAccessibility(Color color) {
    final contrastWithWhite = _calculateContrastRatio(color, Colors.white);
    final contrastWithBlack = _calculateContrastRatio(color, Colors.black);

    return AccessibilityInfo(
      wcagAANormal: contrastWithWhite >= 4.5 || contrastWithBlack >= 4.5,
      wcagAALarge: contrastWithWhite >= 3.0 || contrastWithBlack >= 3.0,
      wcagAAA: contrastWithWhite >= 7.0 || contrastWithBlack >= 7.0,
      bestTextColor: contrastWithWhite > contrastWithBlack ? Colors.white : Colors.black,
    );
  }
}

// 数据模型
class ColorAnalysis {
  final HSLColor hsl;
  final HSVColor hsv;
  final double brightness;
  final bool isLight;
  final bool isDark;
  final bool isVivid;
  final bool isPastel;
  final bool isNeutral;
  final double temperature;
  final double contrastRatio;
  final AccessibilityInfo accessibility;

  ColorAnalysis({
    required this.hsl,
    required this.hsv,
    required this.brightness,
    required this.isLight,
    required this.isDark,
    required this.isVivid,
    required this.isPastel,
    required this.isNeutral,
    required this.temperature,
    required this.contrastRatio,
    required this.accessibility,
  });
}

class ColorHarmony {
  final Color base;
  final Color complementary;
  final List<Color> analogous;
  final List<Color> triadic;
  final List<Color> tetradic;
  final List<Color> split;
  final List<Color> monochromatic;

  ColorHarmony({
    required this.base,
    required this.complementary,
    required this.analogous,
    required this.triadic,
    required this.tetradic,
    required this.split,
    required this.monochromatic,
  });
}

class AccessibilityInfo {
  final bool wcagAANormal;
  final bool wcagAALarge;
  final bool wcagAAA;
  final Color bestTextColor;

  AccessibilityInfo({
    required this.wcagAANormal,
    required this.wcagAALarge,
    required this.wcagAAA,
    required this.bestTextColor,
  });
}
