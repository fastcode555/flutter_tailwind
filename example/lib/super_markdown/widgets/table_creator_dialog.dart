import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class TableCreatorDialog extends StatefulWidget {
  final ValueChanged<String> onCreated;

  const TableCreatorDialog({
    required this.onCreated, super.key,
  });

  @override
  State<TableCreatorDialog> createState() => _TableCreatorDialogState();
}

class _TableCreatorDialogState extends State<TableCreatorDialog> {
  int _rows = 3;
  int _columns = 3;
  bool _hasHeader = true;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: '创建表格'.text.f16.bold.mk,
      content: container.w300.child(
        column.crossStart.children([
          // 行数设置
          _buildNumberSetting(
            label: '行数',
            value: _rows,
            onChanged: (value) => setState(() => _rows = value),
          ),
          h16,
          // 列数设置
          _buildNumberSetting(
            label: '列数',
            value: _columns,
            onChanged: (value) => setState(() => _columns = value),
          ),
          h16,
          // 表头���置
          row.spaceBetween.children([
            '包含表头'.text.f14.mk,
            Switch(
              value: _hasHeader,
              onChanged: (value) => setState(() => _hasHeader = value),
            ),
          ]),
          h24,
          // 预览
          '预览'.text.grey600.f14.mk,
          h8,
          _buildTablePreview(),
        ]),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: '取消'.text.mk,
        ),
        TextButton(
          onPressed: _createTable,
          child: '创建'.text.blue.mk,
        ),
      ],
    );
  }

  Widget _buildNumberSetting({
    required String label,
    required int value,
    required ValueChanged<int> onChanged,
  }) {
    return row.spaceBetween.children([
      label.text.f14.mk,
      container.grey100.rounded4.p8.child(
        DropdownButton<int>(
          value: value,
          items: List.generate(8, (i) => i + 2)
              .map((count) => DropdownMenuItem(
                    value: count,
                    child: count.toString().text.f14.mk,
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
          underline: const SizedBox(),
        ),
      ),
    ]);
  }

  Widget _buildTablePreview() {
    return container.grey100.p8.rounded8.child(
      Table(
        border: TableBorder.all(color: Colors.grey[300]!),
        children: List.generate(_rows, (i) {
          final isHeader = _hasHeader && i == 0;
          return TableRow(
            children: List.generate(
              _columns,
              (j) => container.p8.center.child(
                (isHeader ? '表头' : '内容').text.f12.mk,
              ),
            ),
          );
        }),
      ),
    );
  }

  void _createTable() {
    final buffer = StringBuffer();

    // 生成表头
    buffer.write('|');
    for (var j = 0; j < _columns; j++) {
      buffer.write(' 表头${j + 1} |');
    }
    buffer.writeln();

    // 生成分隔行
    buffer.write('|');
    for (var j = 0; j < _columns; j++) {
      buffer.write(' --- |');
    }
    buffer.writeln();

    // 生成数据行
    for (var i = 0; i < (_hasHeader ? _rows - 1 : _rows); i++) {
      buffer.write('|');
      for (var j = 0; j < _columns; j++) {
        buffer.write(' 内容${i + 1}-${j + 1} |');
      }
      buffer.writeln();
    }

    widget.onCreated(buffer.toString());
    Navigator.pop(context);
  }
} 