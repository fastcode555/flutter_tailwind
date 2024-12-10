import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';

class TableEditor extends StatefulWidget {
  final ValueChanged<String> onChanged;

  const TableEditor({
    required this.onChanged,
    super.key,
  });

  @override
  State<TableEditor> createState() => _TableEditorState();
}

class _TableEditorState extends State<TableEditor> {
  final List<List<TextEditingController>> _controllers = [];
  int _rows = 3;
  int _columns = 3;
  final bool _hasHeader = true;

  @override
  void initState() {
    super.initState();
    _initControllers();
  }

  void _initControllers() {
    _controllers.clear();
    for (var i = 0; i < _rows; i++) {
      final row = <TextEditingController>[];
      for (var j = 0; j < _columns; j++) {
        row.add(TextEditingController()..addListener(_updateMarkdown));
      }
      _controllers.add(row);
    }
  }

  void _updateMarkdown() {
    final buffer = StringBuffer();

    // 生成表头
    buffer.write('|');
    for (var j = 0; j < _columns; j++) {
      buffer.write(' ${_controllers[0][j].text} |');
    }
    buffer.writeln();

    // 生成分隔行
    buffer.write('|');
    for (var j = 0; j < _columns; j++) {
      buffer.write(' --- |');
    }
    buffer.writeln();

    // 生成数据行
    for (var i = 1; i < _rows; i++) {
      buffer.write('|');
      for (var j = 0; j < _columns; j++) {
        buffer.write(' ${_controllers[i][j].text} |');
      }
      buffer.writeln();
    }

    widget.onChanged(buffer.toString());
  }

  @override
  void dispose() {
    for (final row in _controllers) {
      for (final controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      column.children([
        // 表格设置
        _buildTableSettings(),
        h16,

        // 表格编辑器
        container.border1.borderGrey200.rounded8.child(
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: List.generate(
                  _columns,
                  (index) => DataColumn(
                        label: TextField(
                          controller: _controllers[0][index],
                          decoration: const InputDecoration(
                            hintText: '列标题',
                            border: InputBorder.none,
                          ),
                        ),
                      )),
              rows: List.generate(
                  _rows - 1,
                  (i) => DataRow(
                        cells: List.generate(
                            _columns,
                            (j) => DataCell(
                                  TextField(
                                    controller: _controllers[i + 1][j],
                                    decoration: const InputDecoration(
                                      hintText: '单元格内容',
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )),
                      )),
            ),
          ),
        ),

        h16,

        // 预览
        _buildTablePreview(),
      ]),
    );
  }

  Widget _buildTableSettings() {
    return row.children([
      // 行数设置
      column.crossStart.children([
        '行数'.text.grey600.f14.mk,
        h4,
        DropdownButton<int>(
          value: _rows,
          items: List.generate(8, (i) => i + 2)
              .map((count) => DropdownMenuItem(
                    value: count,
                    child: count.toString().text.f14.mk,
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _rows = value;
                _initControllers();
              });
            }
          },
        ),
      ]),

      // 列数设置
      column.crossStart.children([
        '列数'.text.grey600.f14.mk,
        h4,
        DropdownButton<int>(
          value: _columns,
          items: List.generate(8, (i) => i + 2)
              .map((count) => DropdownMenuItem(
                    value: count,
                    child: count.toString().text.f14.mk,
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _columns = value;
                _initControllers();
              });
            }
          },
        ),
      ]),
    ]);
  }

  Widget _buildTablePreview() {
    return container.grey100.p16.rounded8.child(
      Table(
        border: TableBorder.all(color: Colors.grey[300]!),
        children: List.generate(
            _rows,
            (i) => TableRow(
                  children: List.generate(
                      _columns,
                      (j) => container.p8.child(
                            _controllers[i][j].text.text.f14.mk,
                          )),
                )),
      ),
    );
  }
}
