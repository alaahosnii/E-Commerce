import 'package:ecommerce/domain/datasource/categories_datasource.dart';
import 'package:ecommerce/domain/model/categories_result_dto.dart';
import 'package:ecommerce/domain/repository/categories_repository.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  CategoriesDataSource categoriesDataSource;

  CategoriesRepositoryImpl(this.categoriesDataSource);

  @override
  Future<CategoriesResultDto> getCategories() {
    return categoriesDataSource.getCategories();
  }
}
