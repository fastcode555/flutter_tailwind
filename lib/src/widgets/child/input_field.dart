import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/9/11
/// describe:
class InputField extends StatefulWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final String? lableText;
  final String? hintText;
  final InputBorder? border;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;

  final Widget? error;
  final InputBorder? errorBorder;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;

  final TextStyle? floatingLabelStyle;
  final FloatingLabelAlignment? floatingLabelAlignment;
  final FloatingLabelBehavior? floatingLabelBehavior;

  final Color? fillColor;
  final Color? unFocusColor;
  final TextInputType? keyboardType;

  const InputField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.lableText,
    this.hintText,
    this.focusNode,
    this.border,
    this.obscureText = false,
    this.contentPadding,
    this.error,
    this.errorBorder,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.floatingLabelStyle,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.fillColor,
    this.unFocusColor,
    this.keyboardType,
  });

  const InputField.underline({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.lableText,
    this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.contentPadding,
    this.error,
    this.errorBorder,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.floatingLabelStyle,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.fillColor,
    this.unFocusColor,
    this.keyboardType,
  }) : this.border = const UnderlineInputBorder();

  const InputField.outline({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.lableText,
    this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.contentPadding,
    this.error,
    this.errorBorder,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.floatingLabelStyle,
    this.floatingLabelAlignment,
    this.floatingLabelBehavior,
    this.fillColor,
    this.unFocusColor,
    this.keyboardType,
  }) : this.border = const OutlineInputBorder();

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  bool _showClear = false;

  EdgeInsetsGeometry? get _contentPadding {
    if (widget.contentPadding != null) return widget.contentPadding;

    if (widget.border == null || widget.border is UnderlineInputBorder) {
      return const EdgeInsets.symmetric(vertical: 16);
    }

    return null;
  }

  ///Clear的图标
  Widget get _clearWidget => const Icon(Icons.close, size: 18);

  ///尾部图标
  Widget get _suffixIcon {
    if (widget.suffixIcon == null) {
      if (_showClear) {
        return _clearWidget.click(onTap: _handleClear);
      }
      return gapEmpty;
    }
    return Row(
      children: [
        if (_showClear) _clearWidget,
        w2,
        widget.suffixIcon!,
      ],
    ).click(onTap: _handleClear);
  }

  ///清空操作
  void _handleClear() {
    _controller.text = '';
    _showClear = false;
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_listenTextChanged);
    _focusNode.addListener(_focusChanged);
  }

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;
    return TextField(
      controller: _controller,
      cursorColor: primary,
      focusNode: _focusNode,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        prefixIconColor: primary,
        suffixIcon: _suffixIcon,
        fillColor: _focusNode.hasFocus ? widget.fillColor : widget.unFocusColor,
        filled: (widget.fillColor != null || widget.unFocusColor != null),
        suffixIconColor: primary,
        labelText: widget.lableText,
        hintText: widget.hintText,
        border: widget.border,
        contentPadding: _contentPadding,
        error: widget.error,
        errorBorder: widget.errorBorder,
        errorText: widget.errorText,
        errorStyle: widget.errorStyle,
        errorMaxLines: widget.errorMaxLines,
        floatingLabelStyle: widget.floatingLabelStyle,
        floatingLabelAlignment: widget.floatingLabelAlignment,
        floatingLabelBehavior: widget.floatingLabelBehavior,
      ),
    );
  }

  ///listen text changed
  void _listenTextChanged() {
    if (!_focusNode.hasFocus && _showClear) {
      setState(() => _showClear = false);
      return;
    }

    if (_controller.text.isNotEmpty && !_showClear) {
      setState(() => _showClear = true);
      return;
    }

    if (_controller.text.isEmpty && _showClear) {
      setState(() => _showClear = false);
    }
  }

  /// listen focus changed
  void _focusChanged() {
    if (_focusNode.hasFocus && _controller.text.isNotEmpty && !_showClear) {
      setState(() => _showClear = true);
      return;
    }

    if (_showClear && !_focusNode.hasFocus) {
      setState(() => _showClear = false);
      return;
    }

    if (widget.unFocusColor != null || widget.fillColor != null) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listenTextChanged);
  }
}
