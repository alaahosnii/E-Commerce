import 'dart:convert';

import '../../../domain/model/products_metdata_dto.dart';

class Metadata {
  int? currentPage;
  int? numberOfPages;
  int? limit;
  int? nextPage;

  Metadata({
    this.currentPage,
    this.numberOfPages,
    this.limit,
    this.nextPage,
  });

  factory Metadata.fromMap(Map<String, dynamic> data) => Metadata(
        currentPage: data['currentPage'] as int?,
        numberOfPages: data['numberOfPages'] as int?,
        limit: data['limit'] as int?,
        nextPage: data['nextPage'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'currentPage': currentPage,
        'numberOfPages': numberOfPages,
        'limit': limit,
        'nextPage': nextPage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Metadata].
  factory Metadata.fromJson(String data) {
    return Metadata.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  ProductsMetaDataDto toMetaDataDto() {
    return ProductsMetaDataDto(
        currentPage: currentPage,
        limit: limit,
        nextPage: nextPage,
        numberOfPages: numberOfPages);
  }

  /// `dart:convert`
  ///
  /// Converts [Metadata] to a JSON string.
  String toJson() => json.encode(toMap());
}
