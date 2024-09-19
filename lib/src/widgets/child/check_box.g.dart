part of 'check_box.dart';

/// Barry
/// @date 2024/9/13
/// describe:

abstract class _BaseCheckBoxBuilder<T> extends CallBackBuilder<T>
    with
        ColorBuilder,
        BorderColorBuilder,
        SizeBuilder,
        BorderRadiusBuilder,
        BoxShapeBuilder,
        CheckBoxMixin,
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
    if (innerIcon is String && (innerIcon as String).startsWith("http")) {
      return ImageLoader.image(innerIcon, width: _width * _ratio, height: _height * _ratio);
    }

    return Image.asset(innerIcon, width: _width * _ratio, height: _height * _ratio, color: _iconColor);
  }
}

mixin CheckBoxMixin {
  bool _enableBorder = false;
  bool _justIcon = false;
  bool _material = false;
}

extension CheckBoxMixinExt<T extends CheckBoxMixin> on T {
  T get enableBorder => this.._enableBorder = true;

  T get justIcon => this.._justIcon = true;

  T get material => this.._material = true;
}

class AnimatedCheckBox extends StatefulWidget {
  final double? width;
  final double? height;
  final double? size;
  final bool value;
  final Color? color;
  final Color? borderColor;
  final ValueChanged<bool>? onChanged;
  final double? borderWidth;
  final BoxShape shape;
  final BorderRadiusGeometry? borderRadius;
  final bool enableBorder;
  final Widget? icon;
  final bool justIcon;
  final List<BoxShadow>? boxShadow;
  final bool systemStyle;
  final double? ratio;

  const AnimatedCheckBox({
    this.color,
    this.borderColor,
    this.width,
    this.height,
    this.size,
    this.value = false,
    this.onChanged,
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
  _AnimatedCheckBoxState createState() => _AnimatedCheckBoxState();
}

class _AnimatedCheckBoxState extends State<AnimatedCheckBox> {
  bool _isChecked = false;

  bool get _isCircle => widget.shape == BoxShape.circle;

  double get _ratio => widget.ratio ?? (widget.systemStyle ? 0.7 : 0.75);

  @override
  void initState() {
    _isChecked = widget.value;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant AnimatedCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    _isChecked = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    var color = widget.color ?? Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: () {
        setState(() => _isChecked = !_isChecked);
        widget.onChanged?.call(_isChecked);
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
