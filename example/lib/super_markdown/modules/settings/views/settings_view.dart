import 'package:example/super_markdown/modules/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '设置'.text.f20.bold.mk,
      ),
      body: ListView(
        children: [
          // 主题设置
          _buildSection('主题设置', [
            _buildThemeModeSetting(),
            _buildCustomThemeSetting(),
          ]),

          // 编辑器设置
          _buildSection('编辑器设置', [
            _buildSwitchSetting(
              '实时预览',
              '编辑时实时显示预览效果',
              controller.livePreview,
              controller.toggleLivePreview,
            ),
            _buildSwitchSetting(
              '行号显示',
              '显示代码行号',
              controller.showLineNumbers,
              controller.toggleLineNumbers,
            ),
            _buildSwitchSetting(
              '代码折叠',
              '支持代码块折叠',
              controller.codeFolding,
              controller.toggleCodeFolding,
            ),
          ]),

          // 自动保存设置
          _buildSection('自动保存', [
            _buildSwitchSetting(
              '启用自动保存',
              '定期自动保存文档',
              controller.autoSave,
              controller.toggleAutoSave,
            ),
            _buildSelectSetting(
              '保存间隔',
              '自动保存的时间间隔',
              controller.autoSaveInterval.toString(),
              ['30秒', '1分钟', '5分钟', '10分钟'],
              controller.setAutoSaveInterval,
            ),
          ]),

          // 快捷键设置
          _buildSection('快捷键设置', [
            _buildActionSetting(
              '自定义快捷键',
              '配置编辑器快捷键',
              controller.openShortcutSettings,
            ),
          ]),

          // 关于
          _buildSection('关于', [
            _buildInfoSetting('版本', '1.0.0'),
            _buildActionSetting(
              '检查更新',
              '检查新版本',
              controller.checkUpdate,
            ),
            _buildActionSetting(
              '反馈问题',
              '报告问题或提出建议',
              controller.reportIssue,
            ),
          ]),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return column.crossStart.children([
      title.text.black.bold.p16.f16.mk,
      ...children,
    ]);
  }

  Widget _buildThemeModeSetting() {
    return container.white.p16.borderB1.borderGrey200.wFull.child(
      column.crossStart.children([
        '主题模式'.text.f16.mk,
        h8,
        Obx(() => SegmentedButton<ThemeMode>(
              segments: const [
                ButtonSegment(
                  value: ThemeMode.system,
                  label: Text('跟随系统'),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  label: Text('浅色'),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  label: Text('深色'),
                ),
              ],
              selected: {controller.themeMode},
              onSelectionChanged: (Set<ThemeMode> modes) {
                controller.setThemeMode(modes.first);
              },
            )),
      ]),
    );
  }

  Widget _buildCustomThemeSetting() {
    return container.white.p16.borderB1.borderGrey200.child(
      row.spaceBetween.children([
        column.crossStart.expanded.children([
          '自定义主题'.text.f16.mk,
          '自定义编辑器配色方案'.text.grey600.f14.mk,
        ]),
        IconButton(
          icon: Icons.chevron_right.icon.grey600.s24.mk,
          onPressed: controller.openThemeEditor,
        ),
      ]),
    );
  }

  Widget _buildSwitchSetting(
    String title,
    String subtitle,
    RxBool value,
    void Function(bool) onChanged,
  ) {
    return container.white.p16.borderB1.borderGrey200.child(
      row.spaceBetween.children([
        column.crossStart.expanded.children([
          title.text.f16.mk,
          subtitle.text.grey600.f14.mk,
        ]),
        Obx(() => Switch(
              value: value.value,
              onChanged: onChanged,
            )),
      ]),
    );
  }

  Widget _buildSelectSetting(
    String title,
    String subtitle,
    String value,
    List<String> options,
    void Function(String) onChanged,
  ) {
    return container.white.p16.borderB1.borderGrey200.child(
      row.spaceBetween.children([
        column.crossStart.expanded.children([
          title.text.f16.mk,
          subtitle.text.grey600.f14.mk,
        ]),
        DropdownButton<String>(
          value: value,
          items: options
              .map((option) => DropdownMenuItem(
                    value: option,
                    child: option.text.f14.mk,
                  ))
              .toList(),
          onChanged: (value) {
            if (value != null) onChanged(value);
          },
        ),
      ]),
    );
  }

  Widget _buildActionSetting(
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return container.white.p16.borderB1.borderGrey200
        .child(
          row.spaceBetween.children([
            column.crossStart.expanded.children([
              title.text.f16.mk,
              subtitle.text.grey600.f14.mk,
            ]),
            Icons.chevron_right.icon.grey600.s24.mk,
          ]),
        )
        .click(onTap: onTap);
  }

  Widget _buildInfoSetting(String title, String value) {
    return container.white.p16.borderB1.borderGrey200.child(
      row.spaceBetween.children([
        title.text.f16.mk,
        value.text.grey600.f14.mk,
      ]),
    );
  }
}
