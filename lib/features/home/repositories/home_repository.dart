import '../../../core/api/api_client.dart';
import '../models/home_section_model.dart';

 class HomeRepository {
  //Future<List<HomeSectionModel>> getHomeSections();
  final ApiClient _apiClient;
  HomeRepository(this._apiClient);

  Future<List<HomeSectionModel>> fetchProducts() async{
    try{
      final response = await _apiClient.getProducts();
       final List<dynamic> productsJson = response.data['products'];
      return productsJson.map((json) => HomeSectionModel.fromJson(json)).toList();
    }catch (e) {
      throw Exception(e);
    }
  }
}
