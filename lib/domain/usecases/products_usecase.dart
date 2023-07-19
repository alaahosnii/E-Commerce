import 'package:ecommerce/domain/model/products_response_dto.dart';
import 'package:ecommerce/domain/repository/products_repository.dart';

class ProductsUseCase {
  ProductsRepository productsRepository;

  ProductsUseCase(this.productsRepository);

  Future<ProductsResponseDto> invoke() async {
    return productsRepository.getProducts();
  }
}
