import 'dart:convert';

import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:ecommerce/domain/model/categories_result_dto.dart';

import '../../../domain/model/categories_metadata_dto.dart';
import 'datum.dart';
import 'metadata.dart';

class CategoriesResponse {
  int? results;
  Metadata? metadata;
  List<Datum>? data;

  CategoriesResponse({this.results, this.metadata, this.data});

  factory CategoriesResponse.fromMap(Map<String, dynamic> data) {
    return CategoriesResponse(
      results: data['results'] as int?,
      metadata: data['metadata'] == null
          ? null
          : Metadata.fromMap(data['metadata'] as Map<String, dynamic>),
      data: (data['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'results': results,
        'metadata': metadata?.toMap(),
        'data': data?.map((e) => e.toMap()).toList(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CategoriesResponse].
  factory CategoriesResponse.fromJson(String data) {
    return CategoriesResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CategoriesResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
