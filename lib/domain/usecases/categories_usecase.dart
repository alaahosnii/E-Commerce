import 'package:ecommerce/domain/model/categories_result_dto.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';

class CategoriesUseCase {
  CategoriesRepository categoriesRepository;

  CategoriesUseCase(this.categoriesRepository);

  Future<CategoriesResultDto> invoke() async {
    return categoriesRepository.getCategories();
  }
}
