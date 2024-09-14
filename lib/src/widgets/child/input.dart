import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/9/11
/// describe:
class Input extends StatefulWidget {
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

  final int? maxLines;
  final int? maxLength;
  final int? minLines;
  final bool expands;
  final String obscuringCharacter;
  final TextInputAction? textInputAction;
  final TextAlign textAlign;
  final bool? enabled;
  final bool enableSuggestions;
  final Color? cursorErrorColor;
  final double? cursorHeight;
  final TextCapitalization textCapitalization;
  final UndoHistoryController? undoController;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String>? onSubmitted;
  final TapRegionCallback? onTapOutside;

  final FocusScopeNode? scopeNode; //全局焦点处理

  final bool changedDelay;

  final List<TextInputFormatter>? inputFormatters;

  final Color? cursorColor;

  final TextStyle? style;

  final Widget? clearWidget;

  final Widget? visibleWidget;
  final Widget? invisibleWidget;

  const Input({
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
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.expands = false,
    this.obscuringCharacter = '•',
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.enableSuggestions = true,
    this.cursorErrorColor,
    this.cursorHeight,
    this.textCapitalization = TextCapitalization.none,
    this.undoController,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTapOutside,
    this.scopeNode,
    this.changedDelay = true,
    this.inputFormatters,
    this.style,
    this.cursorColor,
    this.clearWidget,
    this.visibleWidget,
    this.invisibleWidget,
  });

  const Input.outline({
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
    this.maxLines,
    this.maxLength,
    this.minLines,
    this.expands = false,
    this.obscuringCharacter = '•',
    this.textInputAction,
    this.textAlign = TextAlign.start,
    this.enabled,
    this.enableSuggestions = true,
    this.cursorErrorColor,
    this.cursorHeight,
    this.textCapitalization = TextCapitalization.none,
    this.undoController,
    this.onChanged,
    this.onEditingComplete,
    this.onSubmitted,
    this.onTapOutside,
    this.scopeNode,
    this.changedDelay = true,
    this.inputFormatters,
    this.style,
    this.cursorColor,
    this.clearWidget,
    this.visibleWidget,
    this.invisibleWidget,
  }) : this.border = const OutlineInputBorder();

  @override
  _InputState createState() => _InputState();
}

class _InputState extends State<Input> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  late bool _obscureText;

  int? _maxLine;

  bool _showClear = false;

  Timer? _timer;

  double? _vertical;

  bool get _isUnderLine => widget.border == null || widget.border is UnderlineInputBorder;

  EdgeInsetsGeometry? get _contentPadding {
    if (widget.contentPadding != null) return widget.contentPadding;

    if (_isUnderLine) {
      return EdgeInsets.symmetric(vertical: _vertical ?? 15);
    }

    return null;
  }

  ///Clear的图标
  Widget get _clearWidget => widget.clearWidget ?? const Icon(Icons.close);

  ///尾部图标
  Widget get _suffixIcon {
    if (widget.suffixIcon == null && widget.visibleWidget == null && widget.invisibleWidget == null) {
      if (_showClear) {
        return _clearWidget.click(onTap: _handleClear);
      }
      return gapEmpty;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (_showClear) _clearWidget,
        if (!_showClear) w18,
        if (widget.suffixIcon != null) ...[w2, widget.suffixIcon!],
        if (widget.visibleWidget != null && _obscureText) ...[
          w2,
          GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: widget.visibleWidget,
          ),
        ],
        if (widget.invisibleWidget != null && !_obscureText) ...[
          w2,
          GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: widget.invisibleWidget,
          ),
        ],
        w8,
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
  void didUpdateWidget(covariant Input oldWidget) {
    super.didUpdateWidget(oldWidget);
    _obscureText = widget.obscureText;
  }

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = widget.focusNode ?? FocusNode();
    _controller.addListener(_listenTextChanged);
    _focusNode.addListener(_focusChanged);
    _getTextFieldSize();

    _obscureText = widget.obscureText;
    _maxLine = widget.maxLines;
    if (widget.invisibleWidget != null && widget.visibleWidget != null) {
      widget.keyboardType == TextInputType.visiblePassword;
      _obscureText = true;
      _maxLine = 1;
    }
  }

  void _getTextFieldSize() {
    if (!_isUnderLine) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final renderBox = context.findRenderObject() as RenderBox;
      _vertical = renderBox.size.height / (widget.lableText != null ? 8 : 4);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var primary = Theme.of(context).primaryColor;
    return TextField(
      controller: _controller,
      cursorColor: widget.cursorColor ?? primary,
      focusNode: _focusNode,
      style: widget.style,
      obscureText: _obscureText,
      keyboardType: widget.keyboardType,
      maxLines: _maxLine,
      maxLength: widget.maxLength,
      minLines: widget.minLines,
      expands: widget.expands,
      obscuringCharacter: widget.obscuringCharacter,
      textInputAction: widget.textInputAction,
      textAlign: widget.textAlign,
      enabled: widget.enabled,
      enableSuggestions: widget.enableSuggestions,
      cursorErrorColor: widget.cursorErrorColor,
      cursorHeight: widget.cursorHeight,
      textCapitalization: widget.textCapitalization,
      undoController: widget.undoController,
      onChanged: _onChanged,
      onEditingComplete: _onEditingComplete,
      onSubmitted: widget.onSubmitted,
      onTapOutside: widget.onTapOutside,
      inputFormatters: widget.inputFormatters,
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

  void _onEditingComplete() {
    if (widget.onEditingComplete != null) {
      widget.onEditingComplete?.call();
      return;
    }

    if (widget.scopeNode != null) {
      widget.scopeNode?.nextFocus();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listenTextChanged);
    _focusNode.removeListener(_focusChanged);
  }

  void _onChanged(String text) {
    if (widget.onChanged != null && widget.changedDelay) {
      if (_timer != null && _timer!.isActive) _timer!.cancel();
      _timer = Timer(const Duration(seconds: 1), () {
        widget.onChanged?.call(text);
      });
      return;
    }

    widget.onChanged?.call(text);
  }
}
