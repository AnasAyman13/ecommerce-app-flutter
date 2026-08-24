import 'package:ecommerce_app/core/constants/storage_keys.dart';
import 'package:ecommerce_app/features/splash/models/app_launch_model.dart';
import 'package:ecommerce_app/features/splash/repositories/splash_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'flutter_secure_storage/etc...';

class SplashRepositoryImpl implements SplashRepository {
  final SharedPreferences _sharedPreferences;

  SplashRepositoryImpl(this._sharedPreferences);

  @override
  Future<AppLaunchModel> getLaunchState() async {
    final hasCompletedOnboarding =
        _sharedPreferences.getBool(StorageKeys.onboardingKey) ?? false;

    final token =
        _sharedPreferences.getString(StorageKeys.authToken) ??
        _sharedPreferences.getString('session_email');
    final isAuthenticated = token != null && token.isNotEmpty;

    return AppLaunchModel(
      isAuthenticated: isAuthenticated,
      hasCompletedOnboarding: hasCompletedOnboarding,
    );
  }
}
