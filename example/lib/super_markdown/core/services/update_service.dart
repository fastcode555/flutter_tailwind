import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class UpdateService extends GetxService {
  static const String _updateUrl = 'https://api.example.com/check-update';
  static const String _currentVersion = '1.0.0';

  // 检查更新
  Future<UpdateInfo?> checkUpdate() async {
    try {
      final response = await http.get(Uri.parse(_updateUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final latestVersion = data['version'];

        if (_compareVersion(latestVersion, _currentVersion) > 0) {
          return UpdateInfo(
            version: latestVersion,
            description: data['description'],
            downloadUrl: data['downloadUrl'],
          );
        }
      }
      return null;
    } catch (e) {
      print('Check update error: $e');
      return null;
    }
  }

  // 比较版本号
  int _compareVersion(String v1, String v2) {
    final v1Parts = v1.split('.');
    final v2Parts = v2.split('.');

    for (var i = 0; i < 3; i++) {
      final v1Part = int.parse(v1Parts[i]);
      final v2Part = int.parse(v2Parts[i]);
      if (v1Part > v2Part) return 1;
      if (v1Part < v2Part) return -1;
    }
    return 0;
  }

  // 下载更新
  Future<bool> downloadUpdate(String url) async {
    try {
      // TODO: 实现下载和安装逻辑
      return true;
    } catch (e) {
      print('Download update error: $e');
      return false;
    }
  }
}

class UpdateInfo {
  final String version;
  final String description;
  final String downloadUrl;

  UpdateInfo({
    required this.version,
    required this.description,
    required this.downloadUrl,
  });
}
