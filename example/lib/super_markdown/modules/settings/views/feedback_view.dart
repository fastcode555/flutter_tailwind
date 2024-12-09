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
          container.blue.rounded8.p12.ph16.m8.center
              .child('提交'.text.white.f14.bold.mk)
              .click(onTap: controller.submitFeedback),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.all(16.r),
        children: [
          // 问题类型
          _buildSection('问题类型', [
            _buildTypeSelector(),
          ]),

          h16,

          // 问题描述
          _buildSection('问题描述', [
            _buildTitleInput(),
            h8,
            _buildDescriptionInput(),
          ]),

          h16,

          // 联系方式
          _buildSection('联系方式 (选填)', [
            _buildEmailInput(),
          ]),

          h16,

          // 截图上传
          _buildSection('截图上传 (选填)', [
            _buildScreenshotUploader(),
          ]),

          h16,

          // 系统信息
          _buildSection('系统信息', [
            _buildSystemInfo(),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return column.crossStart.children([
      title.text.grey600.f14.mk,
      h8,
      ...children,
    ]);
  }

  Widget _buildTypeSelector() {
    return Obx(() => wrap.spacing8.children(
          [
            _buildTypeChip('功能建议', 'feature'),
            _buildTypeChip('程序错误', 'bug'),
            _buildTypeChip('界面优化', 'ui'),
            _buildTypeChip('其他', 'other'),
          ],
        ));
  }

  Widget _buildTypeChip(String label, String value) {
    final isSelected = controller.feedbackType.value == value;
    return ChoiceChip(
      label: label.text.color(isSelected ? Colors.white : Colors.black).f14.mk,
      selected: isSelected,
      onSelected: (selected) {
        if (selected) controller.feedbackType.value = value;
      },
    );
  }

  Widget _buildTitleInput() {
    return container.white.rounded8.p12.border1.borderGrey200.child(
      TextField(
        controller: controller.titleController,
        decoration: const InputDecoration(
          hintText: '请输入问题标题',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildDescriptionInput() {
    return container.white.rounded8.p12.border1.borderGrey200.h200.child(
      TextField(
        controller: controller.descriptionController,
        maxLines: null,
        decoration: const InputDecoration(
          hintText: '请详细描述您遇到的问题或建议',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return container.white.rounded8.p12.border1.borderGrey200.child(
      TextField(
        controller: controller.emailController,
        decoration: const InputDecoration(
          hintText: '请输入您的邮箱地址',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildScreenshotUploader() {
    return container.white.rounded8.p12.border1.borderGrey200.child(
      column.crossStart.children([
        // 已上传的截图
        Obx(() => wrap.spacing8.runSpacing8.children(
              [
                ...controller.screenshots.map(_buildScreenshotItem),
                // 添加按钮
                if (controller.screenshots.length < 5)
                  container.grey100.rounded8.s80.center
                      .child(Icons.add.icon.grey600.s24.mk)
                      .click(onTap: controller.addScreenshot),
              ],
            )),
        if (controller.screenshots.isNotEmpty) ...[
          h8,
          '最多上传5张截图'.text.grey600.f12.mk,
        ],
      ]),
    );
  }

  Widget _buildScreenshotItem(String path) {
    return Stack(
      children: [
        path.image.s80.cover.mk,
        positioned.r0.t0.child(
          container.red.circle.s24.center.child(Icons.close.icon.white.s16.mk).click(
                onTap: () => controller.removeScreenshot(controller.screenshots.indexOf(path)),
              ),
        ),
      ],
    );
  }

  Widget _buildSystemInfo() {
    return container.white.rounded8.p12.border1.borderGrey200.child(
      column.crossStart.children([
        _buildInfoItem('操作系统', controller.systemInfo.value['os']),
        _buildInfoItem('应用版本', controller.systemInfo.value['version']),
        _buildInfoItem('设备型号', controller.systemInfo.value['device']),
      ]),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return container.pv4.child(
      row.spaceBetween.children([
        label.text.grey600.f14.mk,
        value.text.f14.mk,
      ]),
    );
  }
}
