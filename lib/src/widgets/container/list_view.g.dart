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

mixin GridViewFeature {
  ///设置一行的个数的
  int? _crossAxisCount;

  ///设置间距的
  double? _spacing, _mainAxisSpacing, _crossAxisSpacing;

  double? _childWidth;
}

extension GridViewFeatureExt<T extends GridViewFeature> on T {
  T croAxisCount(int count) => this.._crossAxisCount = count;

  T spacing(double spacing) => this.._spacing = spacing;

  T mainAxisSpacing(double mainAxisSpacing) => this.._mainAxisSpacing = mainAxisSpacing;

  T crossAxisSpacing(double crossAxisSpacing) => this.._crossAxisSpacing = crossAxisSpacing;

  T childWidth(double childWidth) => this.._childWidth = childWidth;

  T get childWidth50 => this.._childWidth = 50.r;

  T get childWidth100 => this.._childWidth = 100.r;

  T get childWidth200 => this.._childWidth = 200.r;

  T get crossAxisCount2 => this.._crossAxisCount = 2;

  T get crossAxisCount3 => this.._crossAxisCount = 3;

  T get crossAxisCount4 => this.._crossAxisCount = 4;

  T get crossAxisCount5 => this.._crossAxisCount = 5;

  T get crossAxisCount6 => this.._crossAxisCount = 6;

  T get crossAxisCount7 => this.._crossAxisCount = 7;

  T get crossAxisCount8 => this.._crossAxisCount = 8;

  T get crossAxisCount9 => this.._crossAxisCount = 9;

  T get crossAxisCount10 => this.._crossAxisCount = 10;

  T get spacing2 => this.._spacing = 2.r;

  T get spacing4 => this.._spacing = 4.r;

  T get spacing6 => this.._spacing = 6.r;

  T get spacing8 => this.._spacing = 8.r;

  T get spacing10 => this.._spacing = 10.r;

  T get spacing12 => this.._spacing = 12.r;

  T get spacing14 => this.._spacing = 14.r;

  T get spacing16 => this.._spacing = 16.r;

  T get spacing18 => this.._spacing = 18.r;

  T get spacing20 => this.._spacing = 20.r;

  T get spacing22 => this.._spacing = 22.r;

  T get spacing24 => this.._spacing = 24.r;

  T get spacing26 => this.._spacing = 26.r;

  T get spacing28 => this.._spacing = 28.r;

  T get spacing30 => this.._spacing = 30.r;

  T get spacing32 => this.._spacing = 32.r;

  T get mainSpacing2 => this.._mainAxisSpacing = 2.r;

  T get mainSpacing4 => this.._mainAxisSpacing = 4.r;

  T get mainSpacing6 => this.._mainAxisSpacing = 6.r;

  T get mainSpacing8 => this.._mainAxisSpacing = 8.r;

  T get mainSpacing10 => this.._mainAxisSpacing = 10.r;

  T get mainSpacing12 => this.._mainAxisSpacing = 12.r;

  T get mainSpacing14 => this.._mainAxisSpacing = 14.r;

  T get mainSpacing16 => this.._mainAxisSpacing = 16.r;

  T get mainSpacing18 => this.._mainAxisSpacing = 18.r;

  T get mainSpacing20 => this.._mainAxisSpacing = 20.r;

  T get mainSpacing22 => this.._mainAxisSpacing = 22.r;

  T get mainSpacing24 => this.._mainAxisSpacing = 24.r;

  T get mainSpacing26 => this.._mainAxisSpacing = 26.r;

  T get mainSpacing28 => this.._mainAxisSpacing = 28.r;

  T get mainSpacing30 => this.._mainAxisSpacing = 30.r;

  T get mainSpacing32 => this.._mainAxisSpacing = 32.r;

  T get crossSpacing2 => this.._crossAxisSpacing = 2.r;

  T get crossSpacing4 => this.._crossAxisSpacing = 4.r;

  T get crossSpacing6 => this.._crossAxisSpacing = 6.r;

  T get crossSpacing8 => this.._crossAxisSpacing = 8.r;

  T get crossSpacing10 => this.._crossAxisSpacing = 10.r;

  T get crossSpacing12 => this.._crossAxisSpacing = 12.r;

  T get crossSpacing14 => this.._crossAxisSpacing = 14.r;

  T get crossSpacing16 => this.._crossAxisSpacing = 16.r;

  T get crossSpacing18 => this.._crossAxisSpacing = 18.r;

  T get crossSpacing20 => this.._crossAxisSpacing = 20.r;

  T get crossSpacing22 => this.._crossAxisSpacing = 22.r;

  T get crossSpacing24 => this.._crossAxisSpacing = 24.r;

  T get crossSpacing26 => this.._crossAxisSpacing = 26.r;

  T get crossSpacing28 => this.._crossAxisSpacing = 28.r;

  T get crossSpacing30 => this.._crossAxisSpacing = 30.r;

  T get crossSpacing32 => this.._crossAxisSpacing = 32.r;
}

mixin ScrollFeature {
  Axis? scrollDirection;
  ScrollController? _controller;
  bool _reverse = false;
  bool _shrinkWrap = false;
  ScrollPhysics? _physics;
  IndexedWidgetBuilder? _separatorBuilder;
  bool _expanded = false;
}

extension ScrollFeatureExt<T extends ScrollFeature> on T {
  T get vertical => this..scrollDirection = Axis.vertical;

  T get horizontal => this..scrollDirection = Axis.horizontal;

  T get reverse => this.._reverse = true;

  T get shrinkWrap => this.._shrinkWrap = true;

  T get neverScroll => this.._physics = const NeverScrollableScrollPhysics();

  T scrollController(ScrollController controller) => this.._controller = controller;

  T separatedBuilder(IndexedWidgetBuilder builder) => this.._separatorBuilder = builder;

  T get expanded => this.._expanded = true;
}
