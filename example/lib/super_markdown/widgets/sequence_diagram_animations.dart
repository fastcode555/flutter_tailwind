import 'dart:ui';

import 'package:flutter/material.dart';

class SequenceDiagramAnimations {
  // 消息流动动画
  static Animation<double> createMessageFlowAnimation({
    required AnimationController controller,
    required int index,
    required int total,
    Curve curve = Curves.easeInOut,
  }) {
    return CurvedAnimation(
      parent: controller,
      curve: Interval(
        index / total,
        (index + 1) / total,
        curve: curve,
      ),
    );
  }

  // 渐显动画
  static Animation<double> createFadeInAnimation({
    required AnimationController controller,
    required int index,
    required int total,
    Curve curve = Curves.easeIn,
  }) {
    return CurvedAnimation(
      parent: controller,
      curve: Interval(
        index / total,
        (index + 0.5) / total,
        curve: curve,
      ),
    );
  }

  // 缩放动画
  static Animation<double> createScaleAnimation({
    required AnimationController controller,
    required int index,
    required int total,
    Curve curve = Curves.elasticOut,
  }) {
    return CurvedAnimation(
      parent: controller,
      curve: Interval(
        index / total,
        (index + 1) / total,
        curve: curve,
      ),
    );
  }

  // 滑动动画
  static Animation<Offset> createSlideAnimation({
    required AnimationController controller,
    required int index,
    required int total,
    Curve curve = Curves.easeOutBack,
  }) {
    return Tween<Offset>(
      begin: const Offset(-1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          index / total,
          (index + 1) / total,
          curve: curve,
        ),
      ),
    );
  }

  // 脉冲动画
  static Animation<double> createPulseAnimation({
    required AnimationController controller,
    Duration duration = const Duration(seconds: 2),
  }) {
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 1.2),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1.2, end: 1),
        weight: 1,
      ),
    ]).animate(controller);
  }

  // 闪光动画
  static Animation<double> createShimmerAnimation({
    required AnimationController controller,
  }) {
    return TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween<double>(begin: 0, end: 1),
        weight: 1,
      ),
      TweenSequenceItem(
        tween: Tween<double>(begin: 1, end: 0),
        weight: 1,
      ),
    ]).animate(controller);
  }

  // 路径动画
  static PathAnimation createPathAnimation({
    required AnimationController controller,
    required Path path,
  }) {
    return PathAnimation(
      controller: controller,
      path: path,
    );
  }
}

// 路径动画
class PathAnimation extends Animation<Offset> with AnimationWithParentMixin<double> {
  final AnimationController controller;
  final Path path;
  final _pathMetrics = <PathMetric>[];

  PathAnimation({
    required this.controller,
    required this.path,
  }) {
    _pathMetrics.addAll(path.computeMetrics());
  }

  @override
  Animation<double> get parent => controller;

  @override
  Offset get value {
    final position = controller.value * _pathMetrics[0].length;
    final tangent = _pathMetrics[0].getTangentForOffset(position);
    return tangent?.position ?? Offset.zero;
  }
}