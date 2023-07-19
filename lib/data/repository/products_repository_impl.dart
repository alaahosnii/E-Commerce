import 'package:ecommerce/domain/datasource/products_datasource.dart';
import 'package:ecommerce/domain/model/products_response_dto.dart';
import 'package:ecommerce/domain/repository/products_repository.dart';

class ProductsRepositoryImpl implements ProductsRepository {
  ProductsDataSource productsDataSource;

  ProductsRepositoryImpl(this.productsDataSource);
  @override
  Future<ProductsResponseDto> getProducts() {
    return productsDataSource.getProducts();
  }
}
