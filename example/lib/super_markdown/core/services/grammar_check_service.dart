import 'package:get/get.dart';

class GrammarCheckService extends GetxService {
  // 当前语言
  final Rx<String> _currentLanguage = 'en'.obs;

  // 语法规则
  final Map<String, List<GrammarRule>> _rules = {
    'en': [
      // 重复单词
      GrammarRule(
        name: 'repeated_words',
        pattern: RegExp(r'\b(\w+)\s+\1\b', caseSensitive: false),
        message: 'Repeated word',
        severity: GrammarSeverity.warning,
      ),

      // 句子大写
      GrammarRule(
        name: 'sentence_case',
        pattern: RegExp(r'(?<=[.!?]\s+)[a-z]'),
        message: 'Sentence should start with a capital letter',
        severity: GrammarSeverity.error,
      ),

      // 标点符号空格
      GrammarRule(
        name: 'punctuation_spacing',
        pattern: RegExp('[,.!?][a-zA-Z]'),
        message: 'Space required after punctuation',
        severity: GrammarSeverity.warning,
      ),

      // 被动语态
      GrammarRule(
        name: 'passive_voice',
        pattern: RegExp(r'\b(?:am|is|are|was|were|be|been|being)\s+\w+ed\b'),
        message: 'Consider using active voice',
        severity: GrammarSeverity.info,
      ),

      // 冗长表达
      GrammarRule(
        name: 'wordiness',
        pattern: RegExp(r'\b(in order to|due to the fact that|in spite of)\b'),
        message: 'Consider using a simpler expression',
        severity: GrammarSeverity.info,
        suggestions: {
          'in order to': 'to',
          'due to the fact that': 'because',
          'in spite of': 'despite',
        },
      ),

      // 拼写错误的常见单词
      GrammarRule(
        name: 'common_misspellings',
        pattern: RegExp(r'\b(teh|recieve|seperate|occured)\b'),
        message: 'Possible spelling mistake',
        severity: GrammarSeverity.error,
        suggestions: {
          'teh': 'the',
          'recieve': 'receive',
          'seperate': 'separate',
          'occured': 'occurred',
        },
      ),

      // 不一致的时态
      GrammarRule(
        name: 'tense_consistency',
        pattern: RegExp(r'(?:yesterday|ago)\s+\b(?:is|are|am)\b'),
        message: 'Inconsistent verb tense',
        severity: GrammarSeverity.error,
      ),

      // 多余的标点
      GrammarRule(
        name: 'redundant_punctuation',
        pattern: RegExp('[,.!?]{2,}'),
        message: 'Redundant punctuation',
        severity: GrammarSeverity.warning,
      ),
    ],
    'zh': [
      // 中文标点使用
      GrammarRule(
        name: 'chinese_punctuation',
        pattern: RegExp('[，。！？][a-zA-Z]'),
        message: '中文标点后不应直接跟英文',
        severity: GrammarSeverity.warning,
      ),

      // 中英文混用空格
      GrammarRule(
        name: 'mixed_spacing',
        pattern: RegExp(r'[\u4e00-\u9fa5][a-zA-Z]|[a-zA-Z][\u4e00-\u9fa5]'),
        message: '中英文之间应加空格',
        severity: GrammarSeverity.warning,
      ),

      // 重复标点
      GrammarRule(
        name: 'repeated_punctuation',
        pattern: RegExp('[，。！？]{2,}'),
        message: '重复的标点符号',
        severity: GrammarSeverity.warning,
      ),

      // 错误的数量词搭配
      GrammarRule(
        name: 'measure_word',
        pattern: RegExp(r'[一二三四五六七八九十百千万亿两]\s*[个只条张位]'),
        message: '可能不恰当的量词搭配',
        severity: GrammarSeverity.info,
      ),
    ],
  };

  // 设置语言
  void setLanguage(String language) {
    if (_rules.containsKey(language)) {
      _currentLanguage.value = language;
    }
  }

  // 检查文本
  List<GrammarIssue> checkText(String text) {
    final issues = <GrammarIssue>[];
    final currentRules = _rules[_currentLanguage.value] ?? [];

    for (final rule in currentRules) {
      final matches = rule.pattern.allMatches(text);
      for (final match in matches) {
        issues.add(GrammarIssue(
          rule: rule,
          start: match.start,
          end: match.end,
          text: text.substring(match.start, match.end),
        ));
      }
    }

    return issues;
  }

  // 获取修复建议
  List<String> getSuggestions(GrammarIssue issue) {
    // 如果规则有预定义的建议
    if (issue.rule.suggestions != null) {
      final suggestion = issue.rule.suggestions![issue.text.toLowerCase()];
      if (suggestion != null) {
        return [suggestion];
      }
    }

    // 根据规则类型生成建议
    switch (issue.rule.name) {
      case 'repeated_words':
        return [issue.text.split(' ').first];
      case 'sentence_case':
        return [issue.text[0].toUpperCase() + issue.text.substring(1)];
      case 'punctuation_spacing':
        return ['${issue.text[0]} ${issue.text[1]}'];
      case 'passive_voice':
        // 尝试转换为主动语态
        final parts = issue.text.split(' ');
        if (parts.length >= 2) {
          final verb = parts.last.replaceAll('ed', '');
          return ['$verb ${parts.sublist(0, parts.length - 1).join(' ')}'];
        }
        return [];
      case 'mixed_spacing':
        return [issue.text.split('').join(' ')];
      default:
        return [];
    }
  }

  // 添加自定义规则
  void addCustomRule(String language, GrammarRule rule) {
    _rules[language]?.add(rule);
  }
}

class GrammarRule {
  final String name;
  final RegExp pattern;
  final String message;
  final GrammarSeverity severity;
  final Map<String, String>? suggestions;

  GrammarRule({
    required this.name,
    required this.pattern,
    required this.message,
    required this.severity,
    this.suggestions,
  });
}

enum GrammarSeverity {
  info,
  warning,
  error,
}

class GrammarIssue {
  final GrammarRule rule;
  final int start;
  final int end;
  final String text;

  GrammarIssue({
    required this.rule,
    required this.start,
    required this.end,
    required this.text,
  });
}
