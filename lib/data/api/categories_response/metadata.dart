import 'dart:convert';

import 'package:ecommerce/domain/model/categories_metadata_dto.dart';

class Metadata {
  int? currentPage;
  int? numberOfPages;
  int? limit;

  Metadata({this.currentPage, this.numberOfPages, this.limit});

  factory Metadata.fromMap(Map<String, dynamic> data) => Metadata(
        currentPage: data['currentPage'] as int?,
        numberOfPages: data['numberOfPages'] as int?,
        limit: data['limit'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'currentPage': currentPage,
        'numberOfPages': numberOfPages,
        'limit': limit,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Metadata].
  factory Metadata.fromJson(String data) {
    return Metadata.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Metadata] to a JSON string.
  String toJson() => json.encode(toMap());

  toCategoriesMetaDataDto() {
    return CategoriesMetaDataDto(
        currentPage: currentPage, numberOfPages: numberOfPages, limit: limit);
  }
}
