import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/domain/datasource/products_datasource.dart';
import 'package:ecommerce/domain/model/categories_result_dto.dart';
import 'package:ecommerce/domain/model/products_response_dto.dart';

class productsDataSourceImpl implements ProductsDataSource {
  ApiManager apiManager;

  productsDataSourceImpl(this.apiManager);

  @override
  Future<ProductsResponseDto> getProducts() async {
    var response = await apiManager.getAllProducts();
    return ProductsResponseDto(
      results: response.results,
      metadata: response.metadata?.toMetaDataDto(),
      data: response.data?.map((data) => data.toProductsDataDto()).toList(),
    );
  }
}
