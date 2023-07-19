import 'dart:convert';

import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/domain/model/products_metdata_dto.dart';

import '../../../domain/model/products_response_dto.dart';
import 'datum.dart';
import 'metadata.dart';

class ProductsResponse {
  int? results;
  Metadata? metadata;
  List<Datum>? data;

  ProductsResponse({this.results, this.metadata, this.data});

  factory ProductsResponse.fromMap(Map<String, dynamic> data) {
    return ProductsResponse(
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
  /// Parses the string and returns the resulting Json object as [ProductsResponse].
  factory ProductsResponse.fromJson(String data) {
    return ProductsResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [ProductsResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
