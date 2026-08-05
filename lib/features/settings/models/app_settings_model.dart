import 'package:equatable/equatable.dart';

class AppSettingsModel extends Equatable {
  final bool isDarkMode;
  final bool notificationsEnabled;
  final String languageCode;

  const AppSettingsModel({
    this.isDarkMode = false,
    this.notificationsEnabled = true,
    this.languageCode = 'en',
  });

  AppSettingsModel copyWith({
    bool? isDarkMode,
    bool? notificationsEnabled,
    String? languageCode,
  }) => AppSettingsModel(
    isDarkMode: isDarkMode ?? this.isDarkMode,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    languageCode: languageCode ?? this.languageCode,
  );

  @override
  List<Object> get props => [isDarkMode, notificationsEnabled, languageCode];
}
