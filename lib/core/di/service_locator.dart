import 'package:ecommerce_app/core/api/api_client.dart';
import 'package:ecommerce_app/core/database/fav_local_data_source.dart';
import 'package:ecommerce_app/core/database/fav_local_data_source_imp.dart';
import 'package:ecommerce_app/core/database/fav_repository/favorites_repository.dart';
import 'package:ecommerce_app/core/database/fav_repository/favorites_repository_imp.dart';
import 'package:ecommerce_app/features/home/repositories/home_repository.dart';
import 'package:ecommerce_app/features/onboarding/repositories/onboarding_repository.dart';
import 'package:ecommerce_app/features/onboarding/repositories/onboarding_repository_imp.dart';
import 'package:ecommerce_app/features/onboarding/viewmodels/onboarding_view_model.dart';
import 'package:ecommerce_app/features/splash/repositories/splash_repository.dart';
import 'package:ecommerce_app/features/splash/repositories/splash_repository_imp.dart';
import 'package:ecommerce_app/features/splash/viewmodels/splash_view_model.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/home/viewmodels/home_view_model.dart';
import 'package:ecommerce_app/features/categories/repositories/categories_repository.dart';
import 'package:ecommerce_app/features/listing/repositories/listing_repository.dart';
import 'package:ecommerce_app/features/product_details/repositories/product_details_repository.dart';
import 'package:ecommerce_app/features/search/repositories/search_repository.dart';
import '../../features/auth/repositories/auth_repository.dart';
import '../../features/auth/viewmodels/auth_view_model.dart';

final sl = GetIt.instance;
Future<void> initServiceLocator() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  sl.registerLazySingleton<ApiClient>(() => ApiClient());
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepository(
      apiClient: sl<ApiClient>(),
      preferences: sl<SharedPreferences>(),
    ),
  );
  sl.registerFactory<AuthViewModel>(() => AuthViewModel(sl<AuthRepository>()));

  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepository(sl<ApiClient>()),
  );
  sl.registerLazySingleton<CategoriesRepository>(
    () => DummyJsonCategoriesRepository(sl<ApiClient>()),
  );
  sl.registerLazySingleton<ListingRepository>(
    () => DummyJsonListingRepository(sl<ApiClient>()),
  );
  sl.registerLazySingleton<ProductDetailsRepository>(
    () => DummyJsonProductDetailsRepository(sl<ApiClient>()),
  );
  sl.registerLazySingleton<SearchRepository>(
    () => DummyJsonSearchRepository(sl<ApiClient>()),
  );

  sl.registerLazySingleton<FavLocalDataSource>(() => FavLocalDataSourceImp());

  sl.registerLazySingleton<FavoritesRepository>(
    () => FavoritesRepositoryImp(sl<FavLocalDataSource>()),
  );

  sl.registerFactory<HomeViewModel>(
    () => HomeViewModel(sl<HomeRepository>(), sl<FavoritesRepository>()),
  );
  sl.registerLazySingleton<SplashRepository>(
    () => SplashRepositoryImpl(sl<SharedPreferences>()),
  );
  sl.registerFactory<SplashViewModel>(
    () => SplashViewModel(sl<SplashRepository>()),
  );
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImp(sl<SharedPreferences>()),
  );

  // 2️⃣ Onboarding ViewModel / Cubit
  sl.registerFactory<OnboardingViewModel>(
    () => OnboardingViewModel(sl<OnboardingRepository>()),
  );
}
