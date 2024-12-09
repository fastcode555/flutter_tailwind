import 'package:example/super_markdown/core/services/feedback_service.dart';
import 'package:example/super_markdown/core/services/log_service.dart';
import 'package:example/super_markdown/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tailwind/flutter_tailwind.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class FeedbackController extends GetxController {
  final _feedbackService = Get.find<FeedbackService>();
  final _logService = Get.find<LogService>();
  final _storageService = Get.find<StorageService>();
  final _imagePicker = ImagePicker();

  // 文本控制器
  late final TextEditingController titleController;
  late final TextEditingController descriptionController;
  late final TextEditingController emailController;

  // 反馈类型
  final RxString feedbackType = '功能建议'.obs;
  final List<String> feedbackTypes = [
    '功能建议',
    '问题反馈',
    '性能问题',
    'UI/UX',
    '文档相关',
    '其他',
  ];

  // 反馈内容
  final RxString title = ''.obs;
  final RxString description = ''.obs;
  final RxList<String> screenshots = <String>[].obs;
  final RxList<String> logs = <String>[].obs;

  // 联系方式
  final RxString email = ''.obs;

  // 系统信息
  final Rx<Map<String, dynamic>> systemInfo = Rx<Map<String, dynamic>>({});

  // 提交状态
  final RxBool isSubmitting = false.obs;

  // 反馈历史
  final RxList<FeedbackRecord> history = <FeedbackRecord>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    
    // 初始化控制器
    titleController = TextEditingController();
    descriptionController = TextEditingController();
    emailController = TextEditingController();

    // 添加监听器
    titleController.addListener(() => title.value = titleController.text);
    descriptionController.addListener(() => description.value = descriptionController.text);
    emailController.addListener(() => email.value = emailController.text);

    // 加载系统信息
    systemInfo.value = await _logService.getSystemInfo();
    
    // 加载历史记录
    await _loadHistory();
  }

  @override
  void onClose() {
    // 释放控制器
    titleController.dispose();
    descriptionController.dispose();
    emailController.dispose();
    
    // 清理临时文件
    _clearTempFiles();
    super.onClose();
  }

  // 加载反馈历史
  Future<void> _loadHistory() async {
    history.value = await _feedbackService.getFeedbackHistory();
  }

  // 添加截图
  Future<void> addScreenshot() async {
    try {
      final image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (image != null) {
        // 压缩和保存图片
        final savedPath = await _storageService.saveImage(
          image.path,
          'feedback_screenshots',
        );
        screenshots.add(savedPath);
      }
    } catch (e) {
      Get.snackbar(
        '错误',
        '添加截图失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // 添加日志
  Future<void> addLog() async {
    try {
      final result = await Get.dialog(
        LogSelectorDialog(
          logs: await _logService.getAvailableLogs(),
        ),
      );

      if (result != null) {
        // 复制日志文件
        final savedPath = await _storageService.copyFile(
          result,
          'feedback_logs',
        );
        logs.add(savedPath);
      }
    } catch (e) {
      Get.snackbar(
        '错误',
        '添加日志失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  // 移除截图
  void removeScreenshot(int index) {
    final path = screenshots[index];
    screenshots.removeAt(index);
    _storageService.deleteFile(path);
  }

  // 移除日志
  void removeLog(int index) {
    final path = logs[index];
    logs.removeAt(index);
    _storageService.deleteFile(path);
  }

  // 提交反馈
  Future<void> submitFeedback() async {
    if (!_validateForm() || !_validateFeedbackType()) return;

    try {
      isSubmitting.value = true;

      // 收集系统信息
      final systemInfo = await _logService.getSystemInfo();

      // 创建反馈数据
      final feedback = FeedbackRecord(
        type: feedbackType.value,
        title: title.value,
        description: description.value,
        screenshots: screenshots,
        logs: logs,
        email: email.value,
        timestamp: DateTime.now(),
        systemInfo: systemInfo,
        id: '',
        status: '',
      );

      // 提交反馈
      await _feedbackService.submitFeedback(feedback);

      // 更新历史记录
      history.insert(0, feedback);

      // 清理临时文件
      _clearTempFiles();

      // 返回上一页
      Get.back();
      Get.snackbar(
        '成功',
        '感谢您的反馈！',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        '错误',
        '提交失败: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  // 表单验证
  bool _validateForm() {
    if (title.value.isEmpty) {
      Get.snackbar(
        '错误',
        '请输入标题',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (description.value.isEmpty) {
      Get.snackbar(
        '错误',
        '请输入描述',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (email.value.isNotEmpty && !email.value.isEmail) {
      Get.snackbar(
        '错误',
        '请输入有效的邮箱地址',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  // 验证反馈类型
  bool _validateFeedbackType() {
    if (!feedbackTypes.contains(feedbackType.value)) {
      Get.snackbar(
        '错误',
        '请选择反馈类型',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }
    return true;
  }

  // 清理临时文件
  void _clearTempFiles() {
    screenshots.clear();
    logs.clear();
    _storageService.clearDirectory('feedback_screenshots');
    _storageService.clearDirectory('feedback_logs');
  }

  // 查看反馈详情
  void viewFeedbackDetail(FeedbackRecord record) {}

  // 删除反馈记录
  Future<void> deleteFeedback(FeedbackRecord record) async {}

  // 设置反馈类型
  void setFeedbackType(String type) {
    if (feedbackTypes.contains(type)) {
      feedbackType.value = type;
    }
  }
}

// 反馈记录模型
class FeedbackRecord {
  final String id;
  final String type;
  final String title;
  final String description;
  final List<String> screenshots;
  final List<String> logs;
  final String email;
  final DateTime timestamp;
  final Map<String, dynamic> systemInfo;
  final String status;
  final String? response;
  final DateTime? responseTime;

  FeedbackRecord({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.screenshots,
    required this.logs,
    required this.email,
    required this.timestamp,
    required this.systemInfo,
    required this.status,
    this.response,
    this.responseTime,
  });

  factory FeedbackRecord.fromJson(Map<String, dynamic> json) {
    return FeedbackRecord(
      id: json['id'],
      type: json['type'],
      title: json['title'],
      description: json['description'],
      screenshots: List<String>.from(json['screenshots']),
      logs: List<String>.from(json['logs']),
      email: json['email'],
      timestamp: DateTime.parse(json['timestamp']),
      systemInfo: json['systemInfo'],
      status: json['status'],
      response: json['response'],
      responseTime: json['responseTime'] != null ? DateTime.parse(json['responseTime']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'title': title,
      'description': description,
      'screenshots': screenshots,
      'logs': logs,
      'email': email,
      'timestamp': timestamp.toIso8601String(),
      'systemInfo': systemInfo,
      'status': status,
      'response': response,
      'responseTime': responseTime?.toIso8601String(),
    };
  }
}

// 日志选择对话框
class LogSelectorDialog extends StatelessWidget {
  final List<LogFile> logs;

  const LogSelectorDialog({
    required this.logs, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: '选择日志文件'.text.f16.bold.mk,
      content: container.h300.child(
        ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            return ListTile(
              title: log.name.text.f14.mk,
              subtitle: '${log.size} - ${log.date}'.text.grey600.f12.mk,
              onTap: () => Get.back(result: log.path),
            );
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: Get.back,
          child: '取消'.text.mk,
        ),
      ],
    );
  }
}
