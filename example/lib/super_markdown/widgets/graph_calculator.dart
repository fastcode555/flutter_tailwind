import 'package:example/super_markdown/widgets/function_plotter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class GraphCalculator extends StatefulWidget {
  const GraphCalculator({super.key});

  @override
  State<GraphCalculator> createState() => _GraphCalculatorState();
}

class _GraphCalculatorState extends State<GraphCalculator> {
  final _functions = <String>[].obs;
  final _xMinController = TextEditingController(text: '-10');
  final _xMaxController = TextEditingController(text: '10');
  final _yMinController = TextEditingController(text: '-10');
  final _yMaxController = TextEditingController(text: '10');
  final _functionController = TextEditingController();

  // 函数类型
  final _functionTypes = ['笛卡尔', '参数方程', '极坐标'].obs;
  final _selectedType = '笛卡尔'.obs;

  // 参数方程的第二个函数
  final _paramFunctionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      column.children([
        // 标题栏
        row.spaceBetween.children([
          '图形计算器'.text.f16.bold.mk,
          IconButton(
            icon: Icons.add.icon.grey600.s20.mk,
            onPressed: _addFunction,
          ),
        ]),

        h16,

        // 坐标范围设置
        row.children([
          // X轴范围
          Expanded(
            child: column.crossStart.children([
              'X轴范围'.text.f14.mk,
              h8,
              row.children([
                Expanded(
                  child: TextField(
                    controller: _xMinController,
                    decoration: const InputDecoration(
                      labelText: '最小值',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _xMaxController,
                    decoration: const InputDecoration(
                      labelText: '最大值',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ]),
            ]),
          ),

          // Y轴范围
          Expanded(
            child: column.crossStart.children([
              'Y轴范围'.text.f14.mk,
              h8,
              row.children([
                Expanded(
                  child: TextField(
                    controller: _yMinController,
                    decoration: const InputDecoration(
                      labelText: '最小值',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _yMaxController,
                    decoration: const InputDecoration(
                      labelText: '最大值',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                  ),
                ),
              ]),
            ]),
          ),
        ]),

        h16,

        // 函数类型选择
        row.children([
          '函数类型:'.text.f14.mk,
          Obx(() => DropdownButton<String>(
                value: _selectedType.value,
                items: _functionTypes
                    .map((type) => DropdownMenuItem(
                          value: type,
                          child: type.text.f14.mk,
                        ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    _selectedType.value = value;
                  }
                },
              )),
        ]),

        h16,

        // 函数输入
        Obx(() {
          switch (_selectedType.value) {
            case '参数方程':
              return column.children([
                TextField(
                  controller: _functionController,
                  decoration: const InputDecoration(
                    labelText: 'x(t) = ',
                    hintText: '例如: cos(t)',
                    border: OutlineInputBorder(),
                  ),
                ),
                TextField(
                  controller: _paramFunctionController,
                  decoration: const InputDecoration(
                    labelText: 'y(t) = ',
                    hintText: '例如: sin(t)',
                    border: OutlineInputBorder(),
                  ),
                ),
              ]);
            case '极坐标':
              return TextField(
                controller: _functionController,
                decoration: const InputDecoration(
                  labelText: 'r(θ) = ',
                  hintText: '例如: cos(3*theta)',
                  border: OutlineInputBorder(),
                ),
              );
            default:
              return TextField(
                controller: _functionController,
                decoration: const InputDecoration(
                  labelText: 'y = f(x)',
                  hintText: '例如: sin(x) 或 x^2 + 2*x + 1',
                  border: OutlineInputBorder(),
                ),
              );
          }
        }),

        h16,

        // 函数列表
        Obx(() => column.children(
              _functions.map(_buildFunctionItem).toList(),
            )),

        h16,

        // 图形显示区域
        Expanded(
          child: Obx(() => _functions.isEmpty
              ? container.grey100.rounded8.center.child(
                  '请添加函数'.text.grey600.f14.mk,
                )
              : ListView.separated(
                  itemCount: _functions.length,
                  separatorBuilder: (_, __) => h16,
                  itemBuilder: (context, index) {
                    final function = _functions[index];
                    final isPolar = function.contains('theta');
                    final isParam = function.contains(';');

                    if (isParam) {
                      final parts = function.split(';');
                      return FunctionPlotter(
                        function: parts[0],
                        paramFunction: parts[1],
                        xMin: double.tryParse(_xMinController.text) ?? -10,
                        xMax: double.tryParse(_xMaxController.text) ?? 10,
                        yMin: double.tryParse(_yMinController.text) ?? -10,
                        yMax: double.tryParse(_yMaxController.text) ?? 10,
                        color: _getColor(index),
                      );
                    }

                    return FunctionPlotter(
                      function: function,
                      isPolar: isPolar,
                      xMin: double.tryParse(_xMinController.text) ?? -10,
                      xMax: double.tryParse(_xMaxController.text) ?? 10,
                      yMin: double.tryParse(_yMinController.text) ?? -10,
                      yMax: double.tryParse(_yMaxController.text) ?? 10,
                      color: _getColor(index),
                    );
                  },
                )),
        ),
      ]),
    );
  }

  Widget _buildFunctionItem(String function) {
    return container.grey100.rounded8.p8.child(
      row.spaceBetween.children([
        function.text.f14.mk,
        IconButton(
          icon: Icons.delete.icon.grey600.s16.mk,
          onPressed: () => _removeFunction(function),
        ),
      ]),
    );
  }

  Color _getColor(int index) {
    final colors = [
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.teal,
    ];
    return colors[index % colors.length];
  }

  void _addFunction() {
    var function = _functionController.text.trim();
    if (function.isEmpty) return;

    switch (_selectedType.value) {
      case '参数方程':
        final param = _paramFunctionController.text.trim();
        if (param.isNotEmpty) {
          function = '$function;$param';
        }
      case '极坐标':
        function = function.replaceAll('θ', 'theta');
    }

    if (!_functions.contains(function)) {
      _functions.add(function);
      _functionController.clear();
      _paramFunctionController.clear();
    }
  }

  void _removeFunction(String function) {
    _functions.remove(function);
  }

  @override
  void dispose() {
    _xMinController.dispose();
    _xMaxController.dispose();
    _yMinController.dispose();
    _yMaxController.dispose();
    _functionController.dispose();
    _paramFunctionController.dispose();
    super.dispose();
  }
}
