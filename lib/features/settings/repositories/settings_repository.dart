import '../models/app_settings_model.dart';

abstract interface class SettingsRepository {
  Future<AppSettingsModel> getSettings();

  Future<AppSettingsModel> saveSettings(AppSettingsModel settings);
}
