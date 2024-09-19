part of 'radio.dart';

/// Barry
/// @date 2024/9/13
/// describe:

abstract class _BaseRadioBuilder extends RadioCallBackBuilder
    with
        ColorBuilder,
        BorderColorBuilder,
        SizeBuilder,
        BorderRadiusBuilder,
        BoxShapeBuilder,
        RadioMixin,
        IconBuilder,
        AspectRatioBuilder,
        ShadowBuilder {
  double get _width => width ?? size ?? 28.r;

  double get _height => height ?? size ?? 28.r;

  double get _size => size ?? width ?? height ?? 28.r;

  double get _ratio => innerRatio ?? (_material ? 0.7 : 0.75);

  bool get _isSvg => innerIcon is String && (innerIcon as String).endsWith('.svg');

  Color get _iconColor {
    if (_justIcon) return innerColor ?? Colors.white;

    return Colors.white;
  }

  Widget? get _finalIcon {
    if (innerIcon == null) return null;
    if (innerIcon is String && (innerIcon as String).trim().isEmpty) return null;
    if (innerIcon is IconData) return Icon(innerIcon, size: _size * _ratio, color: _iconColor);
    if (innerIcon is Widget) return innerIcon;
    if (_isSvg) {
      Widget svg = SvgPicture.asset(
        innerIcon,
        width: _width * _ratio,
        height: _height * _ratio,
        colorFilter: ColorFilter.mode(_iconColor, BlendMode.srcIn),
      );
      if (innerRatio == 1) return svg;

      var paddingHorizontal = (1 - _ratio) * _width / 2;
      var paddingVertical = (1 - _ratio) * _height / 2;
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
        child: svg,
      );
    }
    if (innerIcon is String && (innerIcon as String).startsWith('http')) {
      return ImageLoader.image(innerIcon, width: _width * _ratio, height: _height * _ratio);
    }

    return Image.asset(innerIcon, width: _width * _ratio, height: _height * _ratio, color: _iconColor);
  }
}

mixin RadioMixin {
  bool _enableBorder = false;
  bool _justIcon = false;
  bool _material = false;
}

extension RadioMixinExt<T extends RadioMixin> on T {
  ///enable the border
  T get enableBorder => this.._enableBorder = true;

  /// only show the icon,don't have background
  T get justIcon => this.._justIcon = true;

  /// open the material style
  T get material => this.._material = true;
}

class AnimatedRadio<T> extends StatefulWidget {
  final double? width;
  final double? height;
  final double? size;
  final T value;
  final T groupValue;
  final Color? color;
  final Color? borderColor;
  final double? borderWidth;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final bool enableBorder;
  final Widget? icon;
  final bool justIcon;
  final List<BoxShadow>? boxShadow;
  final bool systemStyle;
  final double? ratio;
  final ValueChanged<T> onChanged;

  const AnimatedRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.color,
    this.borderColor,
    this.width,
    this.height,
    this.size,
    this.borderWidth,
    this.borderRadius,
    this.enableBorder = false,
    this.shape = BoxShape.rectangle,
    this.icon,
    this.justIcon = false,
    this.systemStyle = false,
    this.boxShadow,
    this.ratio,
  });

  @override
  _AnimatedRadioState<T> createState() => _AnimatedRadioState<T>();
}

class _AnimatedRadioState<T> extends State<AnimatedRadio<T>> {
  bool _isChecked = false;

  bool get _isCircle => widget.shape == BoxShape.circle;

  double get _ratio => widget.ratio ?? (widget.systemStyle ? 0.7 : 0.75);

  @override
  void initState() {
    _isChecked = widget.value == widget.groupValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedRadio<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isChecked = widget.value == widget.groupValue;
  }

  @override
  Widget build(BuildContext context) {
    var color = widget.color ?? Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        setState(() => _isChecked = widget.groupValue == widget.value);
        widget.onChanged.call(widget.value);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          shape: widget.shape,
          color: (!_isChecked || widget.justIcon || widget.systemStyle) ? Colors.transparent : color,
          border: Border.all(
            color: (!_isChecked || widget.enableBorder) ? widget.borderColor ?? Colors.grey : color,
            width: widget.borderWidth ?? 2.0.r,
          ),
          borderRadius: _isCircle ? null : widget.borderRadius,
          boxShadow: _isChecked ? widget.boxShadow : null,
        ),
        width: widget.width,
        height: widget.height,
        child: _buildChild(color),
      ),
    );
  }

  Widget _buildChild(Color color) {
    if (widget.systemStyle) {
      return _buildSystemStyle(color);
    }
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 200),
      child: _isChecked
          ? widget.icon ??
              Icon(
                Icons.check_rounded,
                key: ValueKey<bool>(_isChecked),
                color: widget.justIcon ? color : Colors.white,
                size: (widget.size ?? 28.r) * _ratio,
              )
          : SizedBox(
              key: ValueKey<bool>(_isChecked),
              width: widget.width ?? 28.r,
              height: widget.height ?? 28.r,
            ),
    );
  }

  Widget _buildSystemStyle(Color color) {
    final ratio = _isChecked ? _ratio : 0.0;
    final paddingHorizontal = (widget.width ?? 28.r) * (1 - ratio) / 2;
    final paddingVertical = (widget.height ?? 28.r) * (1 - ratio) / 2;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      decoration: BoxDecoration(
        shape: widget.shape,
        color: (!_isChecked || widget.justIcon) ? Colors.transparent : color,
        borderRadius: _isCircle ? null : widget.borderRadius,
      ),
    );
  }
}
