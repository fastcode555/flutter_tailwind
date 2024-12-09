import 'dart:async';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

class LogService extends GetxService {
  static const String logDirectory = 'logs';
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  late final Directory _logDir;
  final _logs = <String>[].obs;
  StreamController<String>? _logController;
  IOSink? _logSink;

  // 获取日志列表
  List<String> get logs => _logs;

  @override
  Future<void> onInit() async {
    super.onInit();
    if (!kIsWeb) {
      await _initLogDirectory();
    }
    _startLogging();
  }

  // 初始化日志目录
  Future<void> _initLogDirectory() async {
    final appDir = await getApplicationDocumentsDirectory();
    _logDir = Directory('${appDir.path}/$logDirectory');
    if (!await _logDir.exists()) {
      await _logDir.create(recursive: true);
    }
  }

  // 开始日志记录
  void _startLogging() {
    _logController = StreamController<String>.broadcast();

    if (kIsWeb) {
      // Web 平台的日志处理
      _logController?.stream.listen((message) {
        _logs.add('${DateTime.now()} - $message');
        print(message); // 在控制台显示日志
      });
    } else {
      // 非 Web 平台的日志处理
      try {
        final logFile = File('${_logDir.path}/app_${DateTime.now().toIso8601String()}.log');
        _logSink = logFile.openWrite(mode: FileMode.writeOnlyAppend);
        
        // 记录启动信息
        final startMessage = '=== App Started at ${DateTime.now()} ===';
        _logSink?.writeln(startMessage);
        _logs.add(startMessage);

        // 监听日志流
        _logController?.stream.listen((message) {
          final logMessage = '${DateTime.now()} - $message';
          _logSink?.writeln(logMessage);
          _logs.add(logMessage);
        });
      } catch (e) {
        print('Error initializing log file: $e');
      }
    }
  }

  // 写入日志
  void log(String message, [LogLevel level = LogLevel.info]) {
    final logMessage = '${level.name.toUpperCase()}: $message';
    _logController?.add(logMessage);
  }

  // 获取可用日志文件
  Future<List<LogFile>> getAvailableLogs() async {
    if (kIsWeb) {
      return [
        LogFile(
          name: 'web_log.txt',
          path: 'memory',
          size: _formatFileSize(_logs.join('\n').length),
          date: DateTime.now().toString(),
        )
      ];
    }

    final logs = <LogFile>[];
    await for (final file in _logDir.list()) {
      if (file is File && file.path.endsWith('.log')) {
        final stat = await file.stat();
        logs.add(LogFile(
          name: file.path.split('/').last,
          path: file.path,
          size: _formatFileSize(stat.size),
          date: _formatDate(stat.modified),
        ));
      }
    }

    logs.sort((a, b) => b.date.compareTo(a.date));
    return logs;
  }

  // 导出日志
  Future<void> exportLogs() async {

  }

  // 获取系统信息
  Future<Map<String, dynamic>> getSystemInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final info = <String, dynamic>{
      'app': {
        'name': packageInfo.appName,
        'version': packageInfo.version,
        'buildNumber': packageInfo.buildNumber,
      },
      'platform': Platform.operatingSystem,
      'locale': Platform.localeName,
      'timestamp': DateTime.now().toIso8601String(),
    };

    if (Platform.isAndroid) {
      final androidInfo = await _deviceInfo.androidInfo;
      info['device'] = {
        'manufacturer': androidInfo.manufacturer,
        'model': androidInfo.model,
        'version': androidInfo.version.release,
        'sdk': androidInfo.version.sdkInt,
      };
    } else if (Platform.isIOS) {
      final iosInfo = await _deviceInfo.iosInfo;
      info['device'] = {
        'name': iosInfo.name,
        'model': iosInfo.model,
        'systemName': iosInfo.systemName,
        'systemVersion': iosInfo.systemVersion,
      };
    }

    return info;
  }

  // 清理旧日志
  Future<void> cleanOldLogs({Duration maxAge = const Duration(days: 7)}) async {
    final now = DateTime.now();
    await for (final file in _logDir.list()) {
      if (file is File && file.path.endsWith('.log')) {
        final stat = await file.stat();
        if (now.difference(stat.modified) > maxAge) {
          await file.delete();
        }
      }
    }
  }

  // 格式化文件大小
  String _formatFileSize(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  // 格式化日期
  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  void onClose() {
    _logController?.close();
    _logSink?.close();
    super.onClose();
  }
}

// 日志级别
enum LogLevel {
  debug,
  info,
  warning,
  error,
}

// 日志文件模型
class LogFile {
  final String name;
  final String path;
  final String size;
  final String date;

  LogFile({
    required this.name,
    required this.path,
    required this.size,
    required this.date,
  });
}
