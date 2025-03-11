import 'dart:convert';

import 'package:ecommerce/data/api/products_response/datum.dart';
import 'package:ecommerce/domain/datasource/favorites_response_dto.dart';

class FavoriteResponse {
  String? status;
  int? count;
  List<Datum>? data;

  FavoriteResponse({this.status, this.count, this.data});

  factory FavoriteResponse.fromMap(Map<String, dynamic> data) {
    return FavoriteResponse(
      status: data['status'] as String?,
      count: data['count'] as int?,
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'count': count,
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [FavoriteResponse].
  factory FavoriteResponse.fromJson(String data) {
    return FavoriteResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [FavoriteResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  FavoriteResponseDto toDto() => FavoriteResponseDto(
        status: status,
        count: count,
        data: data?.map((data) => data.toProductsDataDto()).toList(),
      );
}
