class EditorTheme {
  final Map<String, dynamic> settings;

  EditorTheme(this.settings);

  void updateTheme(Map<String, dynamic> newSettings) {
    settings.addAll(newSettings);
  }
}

class SyntaxTheme {
  final Map<String, dynamic> settings;

  SyntaxTheme(this.settings);

  void updateTheme(Map<String, dynamic> newSettings) {
    settings.addAll(newSettings);
  }
}

class UiTheme {
  final Map<String, dynamic> settings;

  UiTheme(this.settings);

  void updateTheme(Map<String, dynamic> newSettings) {
    settings.addAll(newSettings);
  }
}
