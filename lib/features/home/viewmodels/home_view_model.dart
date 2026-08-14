import 'package:ecommerce_app/core/database/fav_repository/favorites_repository.dart';
import 'package:ecommerce_app/core/models/favorite_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/view_state.dart';
import '../models/home_section_model.dart';
import '../repositories/home_repository.dart';

class HomeViewModel extends Cubit<ViewState<List<HomeSectionModel>>> {
  final HomeRepository _repository;
  final FavoritesRepository _favoritesRepository;
  HomeViewModel(this._repository,this._favoritesRepository) : super(const ViewState.initial());

  Future<void> loadHome() async {
    emit(const ViewState.loading());
    try {
      emit(ViewState.success(await _repository.fetchProducts()));
    } catch (error) {
      emit(ViewState.failure(error.toString()));
    }
  }

  Future<void> addToFavorite(HomeSectionModel product) async{
    final favoriteItem = FavoriteItemModel(id: product.id, title: product.title, price: product.price, rating: product.rating, thumbnail: product.thumbnail, availabilityStatus: product.availabilityStatus);
    await _favoritesRepository.addToFavorites(favoriteItem);
  }
  bool isFavorite(int id) {
    return _favoritesRepository.isFavorite(id);
  }

  List<FavoriteItemModel> getFavorites() {
    return _favoritesRepository.getFavorites();
  }
  Future<void> removeFromFavorites(int id) async{
    await _favoritesRepository.removeFromFavorites(id);
  }

  Future<void> toggleFavorite(HomeSectionModel product) async {
    final favoriteItem = FavoriteItemModel(id: product.id, title: product.title, price: product.price, rating: product.rating, thumbnail: product.thumbnail, availabilityStatus: product.availabilityStatus);

    if (isFavorite(product.id)) {
      await _favoritesRepository.removeFromFavorites(product.id);
    } else {
      await _favoritesRepository.addToFavorites(favoriteItem);
    }

    emit(ViewState.success(List.from(state.data ?? [])));  }
}
