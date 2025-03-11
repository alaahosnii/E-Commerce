import 'dart:convert';

import 'brand.dart';
import 'category.dart';
import 'subcategory.dart';

class CartProduct {
  List<Subcategory>? subcategory;
  String? id;
  String? title;
  int? quantity;
  String? imageCover;
  Category? category;
  Brand? brand;
  dynamic ratingsAverage;

  CartProduct({
    this.subcategory,
    this.id,
    this.title,
    this.quantity,
    this.imageCover,
    this.category,
    this.brand,
    this.ratingsAverage,
  });

  factory CartProduct.fromMap(Map<String, dynamic> data) => CartProduct(
        subcategory: (data['subcategory'] as List<dynamic>?)
            ?.map((e) => Subcategory.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['_id'] as String?,
        title: data['title'] as String?,
        quantity: data['quantity'] as int?,
        imageCover: data['imageCover'] as String?,
        category: data['category'] == null
            ? null
            : Category.fromMap(data['category'] as Map<String, dynamic>),
        brand: data['brand'] == null
            ? null
            : Brand.fromMap(data['brand'] as Map<String, dynamic>),
        ratingsAverage: data['ratingsAverage'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'subcategory': subcategory?.map((e) => e.toMap()).toList(),
        '_id': id,
        'title': title,
        'quantity': quantity,
        'imageCover': imageCover,
        'category': category?.toMap(),
        'brand': brand?.toMap(),
        'ratingsAverage': ratingsAverage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CartProduct].
  factory CartProduct.fromJson(String data) {
    return CartProduct.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CartProduct] to a JSON string.
  String toJson() => json.encode(toMap());
}
