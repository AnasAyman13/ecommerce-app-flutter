
import 'package:ecommerce_app/core/api/api_client.dart';
import 'package:ecommerce_app/core/database/fav_local_data_source.dart';
import 'package:ecommerce_app/core/database/fav_local_data_source_imp.dart';
import 'package:ecommerce_app/core/database/fav_repository/favorites_repository.dart';
import 'package:ecommerce_app/core/database/fav_repository/favorites_repository_imp.dart';
import 'package:ecommerce_app/features/home/repositories/home_repository.dart';
import 'package:get_it/get_it.dart';

import '../../features/home/viewmodels/home_view_model.dart';

final sl = GetIt.instance;
 Future<void> initServiceLocator() async{
   sl.registerLazySingleton<ApiClient>(()=> ApiClient());
   
   sl.registerLazySingleton<HomeRepository>(()=> HomeRepository(sl<ApiClient>()));

   sl.registerLazySingleton<FavLocalDataSource>(
           ()=> FavLocalDataSourceImp()
   );

   sl.registerLazySingleton<FavoritesRepository>(
       ()=> FavoritesRepositoryImp(sl<FavLocalDataSource>())
   );

   sl.registerFactory<HomeViewModel>(
         () => HomeViewModel(sl<HomeRepository>(),sl<FavoritesRepository>()),
   );



 }