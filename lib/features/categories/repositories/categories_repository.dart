import '../models/category_model.dart';

abstract interface class CategoriesRepository {
  Future<List<CategoryModel>> getCategories();
}
