import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:flutter_test/flutter_test.dart';

/// 2x scaling mock for verifying every geometry/font value routes through SizeAdapter.
class Mock2xAdapter implements SizeAdapter {
  const Mock2xAdapter();

  @override
  double w(double v) => v * 2;
  @override
  double h(double v) => v * 2;
  @override
  double r(double v) => v * 2;
  @override
  double sp(double v) => v * 2;
}

/// Identity (no-scale) — same as Tailwind's default. Useful when a test wants
/// deterministic geometry without the 2x multiplier.
class IdentityAdapter implements SizeAdapter {
  const IdentityAdapter();

  @override
  double w(double v) => v;
  @override
  double h(double v) => v;
  @override
  double r(double v) => v;
  @override
  double sp(double v) => v;
}

/// Installs `Mock2xAdapter` and resets the Tailwind singleton's screen
/// dimensions and primary color so each test starts from a clean slate.
void setUpMockAdapter() {
  Tailwind.instance.configSizeAdapter(const Mock2xAdapter());
  Tailwind.instance.screenW = 0;
  Tailwind.instance.screenH = 0;
  Tailwind.instance.primaryColor = null;
}

/// Restores `IdentityAdapter` so other tests aren't polluted.
void tearDownAdapter() {
  Tailwind.instance.configSizeAdapter(const IdentityAdapter());
  Tailwind.instance.screenW = 0;
  Tailwind.instance.screenH = 0;
  Tailwind.instance.primaryColor = null;
}

/// Wraps `widget` in a MaterialApp + Scaffold and pumps. Use everywhere instead
/// of `tester.pumpWidget` directly — gives consistent ambient Directionality,
/// Theme, and MediaQuery.
Future<void> pumpBuilder(WidgetTester tester, Widget widget) async {
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: widget)),
  );
}
