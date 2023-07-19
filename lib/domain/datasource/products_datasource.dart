import 'package:ecommerce/domain/model/products_response_dto.dart';

import '../model/categories_result_dto.dart';

abstract class ProductsDataSource {
  Future<ProductsResponseDto> getProducts();
}
