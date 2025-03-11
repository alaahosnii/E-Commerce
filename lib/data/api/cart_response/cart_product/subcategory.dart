import 'dart:convert';

class Subcategory {
  String? id;
  String? name;
  String? slug;
  String? category;

  Subcategory({this.id, this.name, this.slug, this.category});

  factory Subcategory.fromMap(Map<String, dynamic> data) => Subcategory(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        slug: data['slug'] as String?,
        category: data['category'] as String?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'slug': slug,
        'category': category,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Subcategory].
  factory Subcategory.fromJson(String data) {
    return Subcategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Subcategory] to a JSON string.
  String toJson() => json.encode(toMap());
}
