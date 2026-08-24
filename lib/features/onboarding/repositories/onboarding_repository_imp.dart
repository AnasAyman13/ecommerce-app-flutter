import 'package:ecommerce_app/core/constants/storage_keys.dart';
import 'package:ecommerce_app/features/onboarding/models/onboarding_page_model.dart';
import 'package:ecommerce_app/features/onboarding/repositories/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingRepositoryImp implements OnboardingRepository {
  final SharedPreferences _sharedPreferences;

  OnboardingRepositoryImp(this._sharedPreferences);

  @override
  Future<void> isOnboardingVisited() async {
    await _sharedPreferences.setBool(StorageKeys.onboardingKey, true);
  }
}
