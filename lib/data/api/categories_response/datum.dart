import 'dart:convert';

import 'package:ecommerce/domain/model/categories_data_dto.dart';

class Datum {
  String? id;
  String? name;
  String? slug;
  String? image;
  String? category;

  Datum({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.category,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        image: data['image'] as String?,
        category: data['category'] as String?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'image': image,
        'category': category,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  CategoriesDataDto toCategoriesDataDto() {
    return CategoriesDataDto(
        id: id, name: name, slug: slug, image: image, category: category);
  }
}
