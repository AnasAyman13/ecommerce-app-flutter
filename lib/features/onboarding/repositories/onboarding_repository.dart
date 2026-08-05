import '../models/onboarding_page_model.dart';

abstract interface class OnboardingRepository {
  Future<List<OnboardingPageModel>> getPages();

  Future<void> completeOnboarding();
}
