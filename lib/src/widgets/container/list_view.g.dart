/// Barry
/// @date 2024/8/28
/// describe:
part of 'list_view.dart';

typedef ItemListFunction<T> = Widget Function(BuildContext context, int index, T item);

mixin StepMixin {
  int? _step;

  int _itemCount(int? itemCount, NullableIndexedWidgetBuilder? tailBuilder) {
    if (_step == null || itemCount == null || _step! <= 0 || tailBuilder == null) return itemCount ?? 0;
    return itemCount + itemCount ~/ _step!;
  }

  Widget? _itemBuilder(
    BuildContext context,
    int index,
    NullableIndexedWidgetBuilder builder,
    NullableIndexedWidgetBuilder? tailBuilder,
  ) {
    if (_step == null || _step! <= 0 || tailBuilder == null) return builder.call(context, index);
    var realStep = _step! + 1;
    if (index % realStep == _step) {
      return tailBuilder.call(context, index ~/ realStep);
    }
    var realIndex = index - index ~/ realStep;
    return builder.call(context, realIndex);
  }
}

///间隔多少，比如隔5个item，显示一条广告
extension StepMixinExt<T extends StepMixin> on T {
  T step(int step) => this.._step = step;

  T get step1 => this.._step = 1;

  T get step2 => this.._step = 2;

  T get step3 => this.._step = 3;

  T get step4 => this.._step = 4;

  T get step5 => this.._step = 5;

  T get step6 => this.._step = 6;

  T get step7 => this.._step = 7;

  T get step8 => this.._step = 8;

  T get step9 => this.._step = 9;

  T get step10 => this.._step = 10;
}

mixin SeparatorBuilder {
  Widget? _separated;
  double? _separatedValue;
  bool? _isDivider;
}

extension SeparatorBuilderExt<T extends SeparatorBuilder> on T {
  T separated(Widget widget) => this.._separated = widget;

  T get divider => this.._isDivider = true;

  T get separated2 => this.._separatedValue = 2;

  T get separated4 => this.._separatedValue = 4;

  T get separated6 => this.._separatedValue = 6;

  T get separated8 => this.._separatedValue = 8;

  T get separated10 => this.._separatedValue = 10;

  T get separated12 => this.._separatedValue = 12;

  T get separated14 => this.._separatedValue = 14;

  T get separated16 => this.._separatedValue = 16;

  T get separated18 => this.._separatedValue = 18;

  T get separated20 => this.._separatedValue = 20;

  T get separated22 => this.._separatedValue = 22;

  T get separated24 => this.._separatedValue = 24;

  T get separated26 => this.._separatedValue = 26;

  T get separated28 => this.._separatedValue = 28;

  T get separated30 => this.._separatedValue = 30;

  T get separated32 => this.._separatedValue = 32;

  T get separated34 => this.._separatedValue = 34;

  T get separated36 => this.._separatedValue = 36;

  T get separated38 => this.._separatedValue = 38;

  T get separated40 => this.._separatedValue = 40;

  T get separated42 => this.._separatedValue = 42;

  T get separated44 => this.._separatedValue = 44;

  T get separated46 => this.._separatedValue = 46;

  T get separated48 => this.._separatedValue = 48;

  T get separated50 => this.._separatedValue = 50;
}

mixin GridViewFeature {
  ///设置一行的个数的
  int? _crossAxisCount;

  double? _childWidth;

  bool _staggered = false;
}

extension GridViewFeatureExt<T extends GridViewFeature> on T {
  T croAxisCount(int count) => this.._crossAxisCount = count;

  T get staggered => this.._staggered = true;

  T childWidth(double childWidth) => this.._childWidth = childWidth;

  T maxCrossAxisExtent(double childWidth) => this.._childWidth = childWidth;

  T get childWidth50 => this.._childWidth = 50;

  T get childWidth100 => this.._childWidth = 100;

  T get childWidth200 => this.._childWidth = 200;

  T get crossAxisCount2 => this.._crossAxisCount = 2;

  T get crossAxisCount3 => this.._crossAxisCount = 3;

  T get crossAxisCount4 => this.._crossAxisCount = 4;

  T get crossAxisCount5 => this.._crossAxisCount = 5;

  T get crossAxisCount6 => this.._crossAxisCount = 6;

  T get crossAxisCount7 => this.._crossAxisCount = 7;

  T get crossAxisCount8 => this.._crossAxisCount = 8;

  T get crossAxisCount9 => this.._crossAxisCount = 9;

  T get crossAxisCount10 => this.._crossAxisCount = 10;
}

mixin ScrollFeature {
  ScrollController? _controller;
  bool _reverse = false;
  bool _shrinkWrap = false;
  ScrollPhysics? _physics;
  IndexedWidgetBuilder? _separatorBuilder;
}

extension ScrollFeatureExt<T extends ScrollFeature> on T {
  T get reverse => this.._reverse = true;

  T get shrinkWrap => this.._shrinkWrap = true;

  T get neverScroll => this.._physics = const NeverScrollableScrollPhysics();

  T controller(ScrollController controller) => this.._controller = controller;

  T separatedBuilder(IndexedWidgetBuilder builder) => this.._separatorBuilder = builder;
}
