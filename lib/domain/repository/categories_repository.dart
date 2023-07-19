import 'package:ecommerce/domain/model/categories_result_dto.dart';

abstract class CategoriesRepository {
  Future<CategoriesResultDto> getCategories();
}
