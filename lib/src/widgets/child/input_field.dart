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

  const InputField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.focusNode,
  });

  @override
  _InputFieldState createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  Widget get _clearWidget => const Icon(Icons.close, size: 18);
  bool _showClear = false;

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

  void _handleClear() {
    _controller.text = '';
    _showClear = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
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
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon,
        prefixIconColor: primary,
        suffixIcon: _suffixIcon,
        suffixIconColor: primary,
        border: OutlineInputBorder(),
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
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.removeListener(_listenTextChanged);
  }
}
