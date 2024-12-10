import 'package:flutter/services.dart';
import 'package:get/get.dart';

class SpellCheckService extends GetxService {
  // 多语言词典
  final Map<String, Set<String>> _dictionaries = {};

  // 自定义词典
  final Map<String, Set<String>> _customDictionaries = {};

  // 当前语言
  final Rx<String> _currentLanguage = 'en'.obs;

  // 支持的语言
  static const supportedLanguages = {
    'en': 'English',
    'es': 'Español',
    'fr': 'Français',
    'de': 'Deutsch',
    'zh': '中文',
  };

  @override
  void onInit() {
    super.onInit();
    _loadDictionaries();
  }

  Future<void> _loadDictionaries() async {
    for (final lang in supportedLanguages.keys) {
      final data = await rootBundle.loadString('assets/dictionaries/$lang.txt');
      _dictionaries[lang] = data.split('\n').toSet();
      _customDictionaries[lang] = {};
    }
  }

  // 设置当前语言
  void setLanguage(String language) {
    if (supportedLanguages.containsKey(language)) {
      _currentLanguage.value = language;
    }
  }

  // 检查单词拼写
  SpellCheckResult checkWord(String word, {String? language}) {
    final lang = language ?? _currentLanguage.value;
    final normalized = _normalizeWord(word, lang);

    if (_dictionaries[lang]?.contains(normalized) ?? false) {
      return SpellCheckResult(
        word: word,
        isCorrect: true,
        suggestions: [],
      );
    }

    if (_customDictionaries[lang]?.contains(normalized) ?? false) {
      return SpellCheckResult(
        word: word,
        isCorrect: true,
        suggestions: [],
      );
    }

    return SpellCheckResult(
      word: word,
      isCorrect: false,
      suggestions: getSuggestions(word, language: lang),
    );
  }

  // 获取拼写建议
  List<String> getSuggestions(String word, {String? language}) {
    final lang = language ?? _currentLanguage.value;
    if (word.isEmpty) return [];

    final normalized = _normalizeWord(word, lang);
    final suggestions = <String>[];

    // 编辑距离为1的所有可能单词
    suggestions.addAll(_getEditDistance1(normalized));

    // 如果建议太少，添加编辑距离为2的单词
    if (suggestions.length < 5) {
      for (final w in _getEditDistance1(normalized)) {
        suggestions.addAll(_getEditDistance1(w));
      }
    }

    // 过滤并排序建议
    return suggestions.where((s) => _dictionaries[lang]?.contains(s) ?? false).take(5).toList();
  }

  // 添加自定义单词
  void addCustomWord(String word, {String? language}) {
    final lang = language ?? _currentLanguage.value;
    final normalized = _normalizeWord(word, lang);
    _customDictionaries[lang]?.add(normalized);
  }

  // 规范化单词
  String _normalizeWord(String word, String language) {
    switch (language) {
      case 'zh':
        // 中文不需要转换大小写
        return word;
      default:
        return word.toLowerCase();
    }
  }

  // 获取编辑距离为1的所有可能单词
  Set<String> _getEditDistance1(String word) {
    const alphabet = 'abcdefghijklmnopqrstuvwxyz';
    final results = <String>{};

    // 删除一个字符
    for (var i = 0; i < word.length; i++) {
      results.add(word.substring(0, i) + word.substring(i + 1));
    }

    // 替换一个字符
    for (var i = 0; i < word.length; i++) {
      for (final c in alphabet.split('')) {
        results.add(word.substring(0, i) + c + word.substring(i + 1));
      }
    }

    // 插入一个字符
    for (var i = 0; i <= word.length; i++) {
      for (final c in alphabet.split('')) {
        results.add(word.substring(0, i) + c + word.substring(i));
      }
    }

    // 交换相邻字符
    for (var i = 0; i < word.length - 1; i++) {
      results.add(
        word.substring(0, i) + word[i + 1] + word[i] + word.substring(i + 2),
      );
    }

    return results;
  }
}

class SpellCheckResult {
  final String word;
  final bool isCorrect;
  final List<String> suggestions;

  SpellCheckResult({
    required this.word,
    required this.isCorrect,
    required this.suggestions,
  });
}
