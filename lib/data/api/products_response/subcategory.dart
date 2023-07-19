import 'dart:convert';

class Subcategory {
  String? id;
  String? name;
  String? slugh;
  String? category;
  Subcategory({this.category, this.id, this.name, this.slugh});

  factory Subcategory.fromMap(Map<String, dynamic> data) => Subcategory(
        id: data['_id'] as String?,
        name: data['name'] as String?,
        slugh: data['slug'] as String?,
        category: data['category'] as String?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'name': name,
        'slug': slugh,
        'category': category,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Subcategory.fromJson(String data) {
    return Subcategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());
}
