import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class CalculatorHistoryViewer extends StatelessWidget {
  final List<String> history;
  final ValueChanged<String> onSelect;
  final VoidCallback onClear;

  const CalculatorHistoryViewer({
    required this.history,
    required this.onSelect,
    required this.onClear,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return container.white.rounded8.p16.cardShadow.child(
      column.children([
        // 标题栏
        row.spaceBetween.children([
          '计算历史'.text.f16.bold.mk,
          row.children([
            // 导出按钮
            IconButton(
              icon: Icons.download.icon.grey600.s20.mk,
              tooltip: '导出历史记录',
              onPressed: _exportHistory,
            ),
            // 清除按钮
            IconButton(
              icon: Icons.delete.icon.grey600.s20.mk,
              tooltip: '清除历史记录',
              onPressed: onClear,
            ),
          ]),
        ]),

        h16,

        // 历史记录列表
        Expanded(
          child: ListView.separated(
            itemCount: history.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, index) => _buildHistoryItem(history[index]),
          ),
        ),
      ]),
    );
  }

  Widget _buildHistoryItem(String expression) {
    final parts = expression.split('=');
    final input = parts[0].trim();
    final result = parts.length > 1 ? parts[1].trim() : '';

    return container.p8.grey100.child(
      row.spaceBetween.children([
        // 表达式和结果
        Expanded(
          child: column.crossStart.children([
            input.text.f14.mk,
            if (result.isNotEmpty) result.text.grey600.f14.bold.mk,
          ]),
        ),
        // 操作按钮
        row.children([
          // 复制按钮
          IconButton(
            icon: Icons.content_copy.icon.grey600.s16.mk,
            tooltip: '复制结果',
            onPressed: () => _copyToClipboard(result),
          ),
          // 重用按钮
          IconButton(
            icon: Icons.replay.icon.grey600.s16.mk,
            tooltip: '重新使用',
            onPressed: () => onSelect(input),
          ),
        ]),
      ]),
    );
  }

  Future<void> _copyToClipboard(String text) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      Get.snackbar(
        '成功',
        '已复制到剪贴板',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '复制失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void _exportHistory() {
    try {
      // 生成CSV格式的历史记录
      final csv = StringBuffer();
      csv.writeln('表达式,结果');

      for (final item in history) {
        final parts = item.split('=').map((s) => s.trim()).toList();
        final expression = parts[0];
        final result = parts.length > 1 ? parts[1] : '';
        csv.writeln('"$expression","$result"');
      }

      // // 创建Blob对象
      // final bytes = utf8.encode(csv.toString());
      // final blob = html.Blob([bytes]);
      //
      // // 创建下载链接
      // final url = html.Url.createObjectUrlFromBlob(blob);
      // final anchor = html.AnchorElement(href: url)
      //   ..setAttribute('download', 'calculator_history.csv')
      //   ..click();
      //
      // // 清理URL
      // html.Url.revokeObjectUrl(url);

      Get.snackbar(
        '成功',
        '历史记录已导出',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '导出失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
