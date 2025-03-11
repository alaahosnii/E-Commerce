import 'dart:convert';

import 'package:ecommerce/data/api/products_response/datum.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';

class FavoriteResponseDto {
  String? status;
  int? count;
  List<ProductsDataDto>? data;

  FavoriteResponseDto({this.status, this.count, this.data});
}
