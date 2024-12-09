import 'package:example/super_markdown/modules/feedback/controllers/feedback_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class FeedbackView extends GetView<FeedbackController> {
  const FeedbackView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '问题反馈'.text.f20.bold.mk,
        actions: [
          // 提交按钮
          Obx(() => container.blue.rounded8.p12.ph16.m8.center.child('提交'.text.white.f14.bold.mk).click(
                onTap: controller.isSubmitting.value ? null : controller.submitFeedback,
              )),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 反馈类型
          _buildSection(
            '反馈类型',
            _buildTypeSelector(),
          ),

          h16,

          // 标题
          _buildSection(
            '标题',
            TextField(
              onChanged: (value) => controller.title.value = value,
              decoration: const InputDecoration(
                hintText: '请简要描述问题',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          h16,

          // 详细描述
          _buildSection(
            '详细描述',
            TextField(
              onChanged: (value) => controller.description.value = value,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: '请详细描述问题或建议',
                border: OutlineInputBorder(),
              ),
            ),
          ),

          h16,

          // 截图
          _buildSection(
            '截图',
            column.crossStart.children([
              // 截图列表
              Obx(() => controller.screenshots.isEmpty
                  ? '暂无截图'.text.grey600.f14.mk
                  : wrap.spacing8.runSpacing8.children(
                      controller.screenshots.asMap().entries.map((entry) => _buildScreenshot(entry.key)).toList(),
                    )),

              h8,

              // 添加按钮
              TextButton.icon(
                onPressed: controller.addScreenshot,
                icon: Icons.add_photo_alternate.icon.grey600.s20.mk,
                label: '添加截图'.text.f14.mk,
              ),
            ]),
          ),

          h16,

          // 日志
          _buildSection(
            '日志',
            column.crossStart.children([
              // 日志列表
              Obx(() => controller.logs.isEmpty
                  ? '暂无日志'.text.grey600.f14.mk
                  : wrap.spacing8.runSpacing8.children(
                      controller.logs.asMap().entries.map((entry) => _buildLog(entry.key)).toList(),
                    )),

              h8,

              // 添加按钮
              TextButton.icon(
                onPressed: controller.addLog,
                icon: Icons.attach_file.icon.grey600.s20.mk,
                label: '添加日志'.text.f14.mk,
              ),
            ]),
          ),

          h16,

          // 联系方式
          _buildSection(
            '联系方式（选填）',
            TextField(
              onChanged: (value) => controller.email.value = value,
              decoration: const InputDecoration(
                hintText: '请输入您的邮箱，方便我们联系您',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget child) {
    return column.crossStart.children([
      title.text.f16.bold.mk,
      child,
    ]);
  }

  Widget _buildScreenshot(int index) {
    return Stack(
      children: [
        // 图片预览
        controller.screenshots[index].asset.s100.rounded8.border1.borderGrey200.cover.mk,
        // 删除按钮
        Positioned(
          right: 4,
          top: 4,
          child: container.red.rounded4.p4
              .child(Icons.close.icon.white.s16.mk)
              .click(onTap: () => controller.removeScreenshot(index)),
        ),
      ],
    );
  }

  Widget _buildLog(int index) {
    return container.grey100.rounded8.p8.child(
      row.children([
        // 日志名称
        Icons.description.icon.grey600.s20.mk,
        controller.logs[index].split('/').last.text.f14.mk,

        // 删除按钮
        IconButton(
          icon: Icons.close.icon.grey600.s16.mk,
          onPressed: () => controller.removeLog(index),
        ),
      ]),
    );
  }

  Widget _buildTypeChip(String label, String value) {
    final isSelected = controller.feedbackType.value == value;
    return ChoiceChip(
      label: label.text.color(isSelected ? Colors.white : Colors.black).f14.mk,
      selected: isSelected,
      onSelected: (selected) {
        if (selected) controller.setFeedbackType(value);
      },
    );
  }

  Widget _buildTypeSelector() {
    return Obx(() => wrap.spacing8.children(
          controller.feedbackTypes.map((type) => _buildTypeChip(type, type)).toList(),
        ));
  }
}
