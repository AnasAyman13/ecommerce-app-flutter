import '../models/app_launch_model.dart';

abstract interface class SplashRepository {
  Future<AppLaunchModel> getLaunchState();
}
