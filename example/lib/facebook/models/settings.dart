class Settings {
  final bool isDarkMode;
  final String language;
  final bool notificationsEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final bool autoPlayVideos;
  final bool dataUsageOptimization;

  Settings({
    this.isDarkMode = false,
    this.language = 'zh_CN',
    this.notificationsEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.autoPlayVideos = true,
    this.dataUsageOptimization = false,
  });

  Settings copyWith({
    bool? isDarkMode,
    String? language,
    bool? notificationsEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    bool? autoPlayVideos,
    bool? dataUsageOptimization,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      autoPlayVideos: autoPlayVideos ?? this.autoPlayVideos,
      dataUsageOptimization: dataUsageOptimization ?? this.dataUsageOptimization,
    );
  }
} 