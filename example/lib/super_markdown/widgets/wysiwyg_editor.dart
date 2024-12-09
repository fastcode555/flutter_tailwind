import 'package:example/super_markdown/core/services/editor_service.dart';
import 'package:example/super_markdown/core/theme/editor_theme.dart';
import 'package:example/super_markdown/widgets/wysiwyg_toolbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class WysiwygEditor extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String>? onChanged;
  final EditorTheme? theme;

  const WysiwygEditor({
    super.key,
    this.initialValue = '',
    this.onChanged,
    this.theme,
  });

  @override
  State<WysiwygEditor> createState() => _WysiwygEditorState();
}

class _WysiwygEditorState extends State<WysiwygEditor> {
  late final QuillController _controller;
  late final FocusNode _focusNode;
  late final ScrollController _scrollController;
  final _editorService = Get.find<EditorService>();

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _scrollController = ScrollController();

    // 将初始Markdown转换为Delta
    final delta = _editorService.parseMarkdown(widget.initialValue);
    _controller = QuillController(
      document: Document.fromDelta(delta),
      selection: const TextSelection.collapsed(offset: 0),
    );

    // 监听内容变化
    _controller.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    if (widget.onChanged != null) {
      final markdown = _editorService.toMarkdown(_controller.document.toDelta());
      widget.onChanged!(markdown);
    }
  }

  @override
  Widget build(BuildContext context) {
    return column.children([
      // 工具栏
      WysiwygToolbar(controller: _controller),

      // 编辑区域
      Expanded(
        child: container.p16.child(
          QuillEditor(
            controller: _controller,
            focusNode: _focusNode,
            scrollController: _scrollController,
            configurations: QuillEditorConfigurations(
              expands: true,
              // 应用主题
              customStyles: DefaultStyles(
                h1: DefaultTextBlockStyle(
                  widget.theme?.h1TextStyle ?? const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  const HorizontalSpacing(16, 0),
                  VerticalSpacing.zero,
                  VerticalSpacing.zero,
                  null,
                ),
                h2: DefaultTextBlockStyle(
                  widget.theme?.h2TextStyle ?? const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  const HorizontalSpacing(16, 0),
                  VerticalSpacing.zero,
                  VerticalSpacing.zero,
                  null,
                ),
                h3: DefaultTextBlockStyle(
                  widget.theme?.h3TextStyle ?? const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  const HorizontalSpacing(16, 0),
                  VerticalSpacing.zero,
                  VerticalSpacing.zero,
                  null,
                ),
                paragraph: DefaultTextBlockStyle(
                  widget.theme?.paragraphStyle ?? const TextStyle(fontSize: 16),
                  HorizontalSpacing.zero,
                  VerticalSpacing.zero,
                  VerticalSpacing.zero,
                  null,
                ),
                code: DefaultTextBlockStyle(
                  widget.theme?.codeStyle ?? ts.f14.grey.mk,
                  const HorizontalSpacing(16, 0),
                  VerticalSpacing.zero,
                  VerticalSpacing.zero,
                  BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
