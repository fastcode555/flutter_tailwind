import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

/// Barry
/// @date 2024/9/11
/// describe:

class Input extends StatefulWidget {
  /// Global default builder for the clear-button widget shown when the input
  /// has text. Per-instance `clearWidget` takes precedence; if both are null,
  /// falls back to `Icon(Icons.close)`.
  ///
  /// Set once at app startup, e.g.:
  /// ```dart
  /// Input.defaultClearWidget = () => const Icon(Icons.cancel, size: 18, color: Colors.grey);
  /// ```
  static Widget Function()? defaultClearWidget;

  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Widget? visibleWidget;
  final Widget? invisibleWidget;

  final Widget Function(bool hasFocus)? prefixIconBuilder;
  final Widget Function(bool hasFocus)? suffixIconBuilder;
  final Widget Function(bool hasFocus)? visibleWidgetBuilder;
  final Widget Function(bool hasFocus)? invisibleWidgetBuilder;

  final FocusNode? focusNode;
  final String? lableText;
  final String? hintText;
  final InputBorder? border;

  /// True when built via [Input.outline]. Lets the state fall back to a
  /// default outline only when no border is supplied AND none is configured
  /// globally via [InputConfig.border].
  final bool outlined;

  final InputBorder? enabledBorder;
  final InputBorder? disabledBorder;
  final bool obscureText;
  final EdgeInsetsGeometry? contentPadding;

  final Widget? error;
  final InputBorder? errorBorder;
  final String? errorText;
  final TextStyle? errorStyle;
  final int? errorMaxLines;

  /// Form validation. When set, [Input] works inside a Form; returning a
  /// non-null string shows it as the error below the field on validate().
  final FormFieldValidator<String>? validator;
  final AutovalidateMode? autovalidateMode;

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
  final bool readOnly;
  final bool enableSuggestions;
  final bool autocorrect;
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
  final TextStyle? hintStyle;
  final TextStyle? suffixStyle;

  final Widget? clearWidget;

  final BoxConstraints? prefixIconConstraints;
  final BoxConstraints? suffixIconConstraints;

  const Input({
    super.key,
    this.controller,
    this.prefixIcon,
    this.prefixIconBuilder,
    this.suffixIconBuilder,
    this.visibleWidgetBuilder,
    this.invisibleWidgetBuilder,
    this.suffixIcon,
    this.lableText,
    this.hintText,
    this.focusNode,
    this.border,
    this.enabledBorder,
    this.disabledBorder,
    this.obscureText = false,
    this.contentPadding,
    this.error,
    this.errorBorder,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.validator,
    this.autovalidateMode,
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
    this.readOnly = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
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
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.hintStyle,
    this.suffixStyle,
    this.outlined = false,
  });

  const Input.outline({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixIconBuilder,
    this.suffixIconBuilder,
    this.visibleWidgetBuilder,
    this.invisibleWidgetBuilder,
    this.lableText,
    this.hintText,
    this.focusNode,
    this.obscureText = false,
    this.contentPadding,
    this.error,
    this.enabledBorder,
    this.disabledBorder,
    this.errorBorder,
    this.errorText,
    this.errorStyle,
    this.errorMaxLines,
    this.validator,
    this.autovalidateMode,
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
    this.readOnly = false,
    this.enableSuggestions = true,
    this.autocorrect = true,
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
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.hintStyle,
    this.suffixStyle,
    final InputBorder? border,
  })  : border = border,
        outlined = true;

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

  /// App-wide `Input` defaults; per-instance props override these.
  InputConfig get _cfg => Tailwind.instance.inputConfig;

  /// Effective border after folding in the global config default.
  InputBorder? get _border =>
      widget.border ??
      _cfg.border ??
      (widget.outlined ? const OutlineInputBorder() : null);

  bool get _isUnderLine => _border == null || _border is UnderlineInputBorder;

  EdgeInsetsGeometry? get _contentPadding {
    // per-instance ?? global config ?? underline-computed fallback
    if (widget.contentPadding != null) return widget.contentPadding;
    if (_cfg.contentPadding != null) return _cfg.contentPadding;

    if (_isUnderLine) {
      return EdgeInsets.symmetric(vertical: sr(_vertical ?? 15));
    }

    return null;
  }

  ///Clear的图标
  Widget get _clearWidget =>
      widget.clearWidget ??
      Input.defaultClearWidget?.call() ??
      const Icon(Icons.close);

  /// The clear button is hidden on read-only fields — a read-only value
  /// shouldn't be user-clearable.
  bool get _clearVisible => _showClear && !widget.readOnly;

  bool get _hasObSecureWidget =>
      widget.visibleWidget != null ||
      widget.invisibleWidget != null ||
      widget.invisibleWidgetBuilder != null ||
      widget.visibleWidgetBuilder != null;

  bool get _hasSuffix => widget.suffixIcon != null || _hasObSecureWidget;

  bool get _hasFocusBuilder =>
      widget.invisibleWidgetBuilder != null ||
      widget.visibleWidgetBuilder != null ||
      widget.prefixIconBuilder != null ||
      widget.suffixIconBuilder != null;

  ///尾部图标
  Widget get _suffixIcon {
    if (!_hasSuffix) {
      if (_clearVisible) {
        return _clearWidget.click(onTap: _handleClear);
      }
      return gapEmpty;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // show the clear widget; no placeholder gap when it's hidden so the
        // suffix icon hugs the text edge.
        if (_clearVisible) ...[_clearWidget],
        // if (!_showClear) w18,

        //show the suffixIcon
        if (widget.suffixIcon != null) ...[widget.suffixIcon!],
        if (widget.suffixIconBuilder != null) ...[
          w2,
          widget.suffixIconBuilder!.call(_focusNode.hasFocus)
        ],

        // show the visibleWidget
        if (widget.visibleWidget != null && _obscureText) ...[
          w2,
          GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: widget.visibleWidget,
          ),
        ],

        if (widget.visibleWidgetBuilder != null && _obscureText) ...[
          w2,
          GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: widget.visibleWidgetBuilder!.call(_focusNode.hasFocus),
          ),
        ],

        // show the invisibleWidget
        if (widget.invisibleWidget != null && !_obscureText) ...[
          w2,
          GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: widget.invisibleWidget,
          ),
        ],
        if (widget.invisibleWidgetBuilder != null && !_obscureText) ...[
          w2,
          GestureDetector(
            onTap: () => setState(() => _obscureText = !_obscureText),
            child: widget.invisibleWidgetBuilder!.call(_focusNode.hasFocus),
          ),
        ],
        w8,
      ],
    ).click(onTap: _handleClear);
  }

  ///清空操作
  void _handleClear() {
    if (widget.readOnly) return;
    _controller.text = '';
    _showClear = false;
    // Cancel any pending debounced onChanged so it doesn't fire after the
    // clear, then notify the consumer immediately with the empty value.
    _timer?.cancel();
    widget.onChanged?.call('');
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
    if (_hasObSecureWidget) {
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
    // Resolve appearance: per-instance ?? global InputConfig ?? hardcoded.
    final cfg = _cfg;
    final effStyle = widget.style ?? cfg.style;
    final effFill = widget.fillColor ?? cfg.fillColor;
    final effUnFocus = widget.unFocusColor ?? cfg.unFocusColor;
    return TextFormField(
      controller: _controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      cursorColor: widget.cursorColor ?? cfg.cursorColor ?? primary,
      focusNode: _focusNode,
      style: effStyle,
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
      readOnly: widget.readOnly,
      enableSuggestions: widget.enableSuggestions,
      autocorrect: widget.autocorrect,
      cursorErrorColor: widget.cursorErrorColor ?? cfg.cursorErrorColor,
      cursorHeight: widget.cursorHeight ?? cfg.cursorHeight,
      textCapitalization: widget.textCapitalization,
      undoController: widget.undoController,
      onChanged: _onChanged,
      onEditingComplete: _onEditingComplete,
      onFieldSubmitted: widget.onSubmitted,
      onTapOutside: widget.onTapOutside,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        prefixIconConstraints: widget.prefixIconConstraints ??
            cfg.prefixIconConstraints ??
            ((widget.prefixIcon != null || widget.prefixIconBuilder != null)
                ? const BoxConstraints()
                : null),
        prefixIcon: widget.prefixIcon != null
            ? container.pl12.child(widget.prefixIcon!)
            : widget.prefixIconBuilder?.call(_focusNode.hasFocus),
        prefixIconColor: primary,
        suffixIcon: _suffixIcon,
        suffixIconConstraints: widget.suffixIconConstraints ??
            cfg.suffixIconConstraints ??
            const BoxConstraints(minWidth: 30),
        fillColor: _focusNode.hasFocus ? effFill : (effUnFocus ?? effFill),
        filled: (effFill != null || effUnFocus != null),
        suffixIconColor: primary,
        labelText: widget.lableText,
        hintText: widget.hintText,
        border: _border,
        suffixStyle: widget.suffixStyle ??
            cfg.suffixStyle ??
            widget.hintStyle ??
            cfg.hintStyle ??
            effStyle?.copyWith(color: effStyle.color?.withValues(alpha: 0.5)),
        hintStyle: widget.hintStyle ??
            cfg.hintStyle ??
            effStyle?.copyWith(color: effStyle.color?.withValues(alpha: 0.5)),
        enabledBorder: widget.enabledBorder ?? cfg.enabledBorder ?? _border,
        disabledBorder: widget.disabledBorder ?? cfg.disabledBorder,
        contentPadding: _contentPadding,
        error: widget.error,
        errorBorder: widget.errorBorder ?? cfg.errorBorder,
        errorText: widget.errorText,
        errorStyle: widget.errorStyle ?? cfg.errorStyle,
        errorMaxLines: widget.errorMaxLines ?? cfg.errorMaxLines,
        floatingLabelStyle:
            widget.floatingLabelStyle ?? cfg.floatingLabelStyle,
        floatingLabelAlignment:
            widget.floatingLabelAlignment ?? cfg.floatingLabelAlignment,
        floatingLabelBehavior:
            widget.floatingLabelBehavior ?? cfg.floatingLabelBehavior,
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

    if (_hasFocusBuilder) {
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
