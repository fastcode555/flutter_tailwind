import 'package:flutter/material.dart';

class SyncScrollController {
  final ScrollController editor;
  final ScrollController preview;
  bool _syncingEditor = false;
  bool _syncingPreview = false;

  SyncScrollController({
    required this.editor,
    required this.preview,
  }) {
    editor.addListener(_onEditorScroll);
    preview.addListener(_onPreviewScroll);
  }

  void _onEditorScroll() {
    if (_syncingPreview) return;
    _syncingEditor = true;

    final editorPosition = editor.position;
    final previewPosition = preview.position;
    final ratio = previewPosition.maxScrollExtent / editorPosition.maxScrollExtent;

    preview.jumpTo(editor.offset * ratio);
    _syncingEditor = false;
  }

  void _onPreviewScroll() {
    if (_syncingEditor) return;
    _syncingPreview = true;

    final editorPosition = editor.position;
    final previewPosition = preview.position;
    final ratio = editorPosition.maxScrollExtent / previewPosition.maxScrollExtent;

    editor.jumpTo(preview.offset * ratio);
    _syncingPreview = false;
  }

  void dispose() {
    editor.removeListener(_onEditorScroll);
    preview.removeListener(_onPreviewScroll);
  }
}
