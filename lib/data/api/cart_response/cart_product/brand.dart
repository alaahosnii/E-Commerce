import 'dart:convert';

class Brand {
  String? id;
  String? name;
  String? slug;
  String? image;

  Brand({this.id, this.name, this.slug, this.image});

  factory Brand.fromMap(Map<String, dynamic> data) => Brand(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        image: data['image'] as String?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'image': image,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Brand].
  factory Brand.fromJson(String data) {
    return Brand.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Brand] to a JSON string.
  String toJson() => json.encode(toMap());
}
