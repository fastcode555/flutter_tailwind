import 'dart:convert';

import 'package:example/super_markdown/modules/feedback/controllers/feedback_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class FeedbackService extends GetxService {
  static const String _feedbackUrl = 'https://api.example.com/feedback';

  // 提交反馈
  Future<bool> submitFeedback(FeedbackRecord data) async {
    try {
      final response = await http.post(
        Uri.parse(_feedbackUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data.toJson()),
      );
      return response.statusCode == 200;
    } catch (e) {
      print('Submit feedback error: $e');
      return false;
    }
  }

  // 获取反馈历史
  Future<List<FeedbackRecord>> getFeedbackHistory() async {
    try {
      final response = await http.get(Uri.parse('$_feedbackUrl/history'));
      if (response.statusCode == 200) {
        final List data = json.decode(response.body);
        return data.map((item) => FeedbackRecord.fromJson(item)).toList();
      }
      return [];
    } catch (e) {
      print('Get feedback history error: $e');
      return [];
    }
  }
}
