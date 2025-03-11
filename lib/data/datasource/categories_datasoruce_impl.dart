import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/domain/datasource/categories_datasource.dart';
import 'package:ecommerce/domain/model/categories_result_dto.dart';

class CategoriesDataSourceImpl implements CategoriesDataSource {
  ApiManager apiManager = ApiManager();

  CategoriesDataSourceImpl(this.apiManager);

  @override
  Future<CategoriesResultDto> getCategories() async {
    var response = await apiManager.getCategories();

    return CategoriesResultDto(
      results: response.results,
      metadata: response.metadata?.toCategoriesMetaDataDto(),
      categoriesList:
          response.data?.map((enity) => enity.toCategoriesDataDto()).toList(),
    );
  }

  @override
  Future<CategoriesResultDto> getSubCategories({required String id}) async {
    var response = await apiManager.getSubCategories(id);

    return CategoriesResultDto(
      results: response.results,
      metadata: response.metadata?.toCategoriesMetaDataDto(),
      categoriesList: response.data
          ?.map((category) => category.toCategoriesDataDto())
          .toList(),
    );
  }
}
