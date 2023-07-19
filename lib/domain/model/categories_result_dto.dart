import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:ecommerce/domain/model/categories_metadata_dto.dart';

class CategoriesResultDto {
  int? results;
  CategoriesMetaDataDto? metadata;
  List<CategoriesDataDto>? categoriesList;

  CategoriesResultDto({this.results, this.metadata, this.categoriesList});
}
