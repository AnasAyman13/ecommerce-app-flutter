import '../models/search_result_model.dart';

abstract interface class SearchRepository {
  Future<List<SearchResultModel>> search(String query);
}
