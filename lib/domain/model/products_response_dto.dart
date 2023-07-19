import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/domain/model/products_metdata_dto.dart';

class ProductsResponseDto {
  int? results;
  ProductsMetaDataDto? metadata;
  List<productsDataDto>? data;

  ProductsResponseDto({this.results, this.metadata, this.data});
}
