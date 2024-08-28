/// Barry
/// @date 2024/8/28
/// describe:
part of 'list_view.dart';

typedef ItemListFunction<T> = Widget Function(BuildContext context, int index, T item);

mixin SeparatorBuilder {
  Widget? _separated;
  double? _separatedValue;
  bool? _isDivider;
}

extension SeparatorBuilderExt<T extends SeparatorBuilder> on T {
  T separated(Widget widget) => this.._separated = widget;

  T get divider => this.._isDivider = true;

  T get separated2 => this.._separatedValue = 2.r;

  T get separated4 => this.._separatedValue = 4.r;

  T get separated6 => this.._separatedValue = 6.r;

  T get separated8 => this.._separatedValue = 8.r;

  T get separated10 => this.._separatedValue = 10.r;

  T get separated12 => this.._separatedValue = 12.r;

  T get separated14 => this.._separatedValue = 14.r;

  T get separated16 => this.._separatedValue = 16.r;

  T get separated18 => this.._separatedValue = 18.r;

  T get separated20 => this.._separatedValue = 20.r;

  T get separated22 => this.._separatedValue = 22.r;

  T get separated24 => this.._separatedValue = 24.r;

  T get separated26 => this.._separatedValue = 26.r;

  T get separated28 => this.._separatedValue = 28.r;

  T get separated30 => this.._separatedValue = 30.r;

  T get separated32 => this.._separatedValue = 32.r;

  T get separated34 => this.._separatedValue = 34.r;

  T get separated36 => this.._separatedValue = 36.r;

  T get separated38 => this.._separatedValue = 38.r;

  T get separated40 => this.._separatedValue = 40.r;

  T get separated42 => this.._separatedValue = 42.r;

  T get separated44 => this.._separatedValue = 44.r;

  T get separated46 => this.._separatedValue = 46.r;

  T get separated48 => this.._separatedValue = 48.r;

  T get separated50 => this.._separatedValue = 50.r;
}

mixin ScrollFeature {
  Axis? scrollDirection;
  ScrollController? _controller;
  bool _reverse = false;
  bool _shrinkWrap = false;
  ScrollPhysics? _physics;
  IndexedWidgetBuilder? _separatorBuilder;
}

extension ScrollFeatureExt<T extends ScrollFeature> on T {
  T get vertical => this..scrollDirection = Axis.vertical;

  T get horizontal => this..scrollDirection = Axis.horizontal;

  T get reverse => this.._reverse = true;

  T get shrinkWrap => this.._shrinkWrap = true;

  T get neverScroll => this.._physics = const NeverScrollableScrollPhysics();

  T scrollController(ScrollController controller) => this.._controller = controller;

  T separatedBuilder(IndexedWidgetBuilder builder) => this.._separatorBuilder = builder;
}
