import '../model/categories_result_dto.dart';

abstract class CategoriesDataSource {
  Future<CategoriesResultDto> getCategories();
}
