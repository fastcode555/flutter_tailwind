
class AutoCompleteProvider {
  // 提示类型
  static const markdownSyntax = {
    '#': ['# 标题1', '## 标题2', '### 标题3'],
    '*': ['*斜体*', '**粗体**', '***粗斜体***'],
    '[': ['[链接文字](URL)', '![图片描述](URL)'],
    '`': ['`代码`', '```\n代码块\n```'],
    '-': ['- 无序列表', '1. 有序列表'],
    '>': ['> 引用'],
    '|': ['| 表头 | 表头 |\n| --- | --- |\n| 内容 | 内容 |'],
    r'$': [r'$行内公式$', '\$\$\n数学公式\n\$\$'],
  };

  // LaTeX符号
  static const mathSymbols = {
    r'\': [
      r'\alpha', r'\beta', r'\gamma', r'\delta',
      r'\sum', r'\int', r'\frac{a}{b}', r'\sqrt{x}',
      r'\lim_{x \to \infty}', r'\begin{matrix}',
    ],
  };

  // 流程图语法
  static const flowchartSyntax = {
    '[': [
      '[id: label]',
      '[id: label (shape)]',
      '[id: label {style}]',
    ],
    '->': [
      'id1 -> id2',
      'id1 -> id2: label',
      'id1 -> id2 {style}',
    ],
  };

  // 时序图语法
  static const sequenceSyntax = {
    'participant': ['participant A', 'participant B as "名称"'],
    'note': [
      'note left of A: 说明',
      'note right of A: 说明',
      'note over A,B: 说明',
    ],
    '->': [
      'A->B: 消息',
      'A-->B: 虚线消息',
      'A->>B: 箭头消息',
    ],
    'loop': ['loop 循环条件\n  消息\nend'],
    'alt': ['alt 条件\n  消息\nelse\n  消息\nend'],
  };

  // 获取提示
  static List<String> getSuggestions(String text, int cursorPosition) {
    // 获取光标前的字符
    final prefix = text.substring(0, cursorPosition);
    final lastChar = prefix.isEmpty ? '' : prefix[prefix.length - 1];
    final lastLine = prefix.split('\n').last;

    // 检查是否在代码块中
    if (_isInCodeBlock(text, cursorPosition)) {
      return _getCodeBlockSuggestions(lastLine);
    }

    // 检查是否在数学公式中
    if (_isInMathBlock(text, cursorPosition)) {
      return _getMathSuggestions(lastChar);
    }

    // 检查是否在流程图中
    if (_isInFlowchart(text, cursorPosition)) {
      return _getFlowchartSuggestions(lastChar);
    }

    // 检查是否在时序图中
    if (_isInSequenceDiagram(text, cursorPosition)) {
      return _getSequenceSuggestions(lastLine);
    }

    // 默认返回Markdown语法提示
    return markdownSyntax[lastChar] ?? [];
  }

  static bool _isInCodeBlock(String text, int position) {
    final beforeCursor = text.substring(0, position);
    final codeBlocks = '```'.allMatches(beforeCursor);
    return codeBlocks.length % 2 == 1;
  }

  static bool _isInMathBlock(String text, int position) {
    final beforeCursor = text.substring(0, position);
    final mathBlocks = r'$$'.allMatches(beforeCursor);
    return mathBlocks.length % 2 == 1;
  }

  static bool _isInFlowchart(String text, int position) {
    final beforeCursor = text.substring(0, position);
    return beforeCursor.contains('```flowchart') &&
        !beforeCursor.contains('```\n', beforeCursor.lastIndexOf('```flowchart'));
  }

  static bool _isInSequenceDiagram(String text, int position) {
    final beforeCursor = text.substring(0, position);
    return beforeCursor.contains('```sequence') &&
        !beforeCursor.contains('```\n', beforeCursor.lastIndexOf('```sequence'));
  }

  static List<String> _getCodeBlockSuggestions(String line) {
    // 根据不同的编程语言返回相应的提示
    return [];
  }

  static List<String> _getMathSuggestions(String lastChar) {
    return mathSymbols[lastChar] ?? [];
  }

  static List<String> _getFlowchartSuggestions(String lastChar) {
    return flowchartSyntax[lastChar] ?? [];
  }

  static List<String> _getSequenceSuggestions(String line) {
    final firstWord = line.trim().split(' ').first;
    return sequenceSyntax[firstWord] ?? [];
  }
} 