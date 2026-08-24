import '../models/category_model.dart';
import '../../../core/api/api_client.dart';

class DummyJsonCategoriesRepository implements CategoriesRepository {
  final ApiClient _apiClient;

  DummyJsonCategoriesRepository(this._apiClient);

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await _apiClient.getCategories();
    final values = response.data as List<dynamic>? ?? const [];
    const allowed = {'furniture', 'home-decoration', 'kitchen-accessories'};
    return values
        .where((value) {
          final map = value is Map<String, dynamic>
              ? value
              : <String, dynamic>{};
          return allowed.contains('${map['slug'] ?? value}');
        })
        .map((value) {
          final map = value is Map<String, dynamic>
              ? value
              : <String, dynamic>{};
          final slug = '${map['slug'] ?? value}';
          return CategoryModel(
            id: slug,
            name: '${map['name'] ?? slug}',
            imageUrl: '',
          );
        })
        .toList();
  }
}

abstract interface class CategoriesRepository {
  Future<List<CategoryModel>> getCategories();
}
