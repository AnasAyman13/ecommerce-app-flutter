import '../models/home_section_model.dart';

abstract interface class HomeRepository {
  Future<List<HomeSectionModel>> getHomeSections();
}
