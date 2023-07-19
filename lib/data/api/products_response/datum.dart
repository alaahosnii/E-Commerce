import 'dart:convert';

import 'package:ecommerce/domain/model/products_data_dto.dart';

import 'brand.dart';
import 'category.dart';
import 'subcategory.dart';

class Datum {
  // int? sold;
  // List<String>? images;
  // List<Subcategory>? subcategory;
  // int? ratingsQuantity;
  // String? id;
  String? title;
  // String? slug;
  // String? description;
  // int? quantity;
  int? price;
  String? imageCover;
  // Category? category;
  // Brand? brand;
  double? ratingsAverage;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // int? priceAfterDiscount;
  // List<dynamic>? availableColors;

  Datum({
    // this.sold,
    // this.images,
    // this.subcategory,
    // this.ratingsQuantity,
    // this.id,
    this.title,
    // this.slug,
    // this.description,
    // this.quantity,
    this.price,
    this.imageCover,
    // this.category,
    // this.brand,
    this.ratingsAverage,
    // this.createdAt,
    // this.updatedAt,
    // this.priceAfterDiscount,
    // this.availableColors,
  });

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        // sold: data['sold'] as int?,
        // images: data['images'] as List<String>?,
        // ratingsQuantity: data['ratingsQuantity'] as int?,
        // id: data['_id'] as String?,
        title: data['title'] as String?,
        // slug: data['slug'] as String?,
        // description: data['description'] as String?,
        // quantity: data['quantity'] as int?,
        price: data['price'] as int?,
        imageCover: data['imageCover'] as String?,
        // category: data['category'] == null
        //     ? null
        //     : Category.fromMap(data['category'] as Map<String, dynamic>),
        // brand: data['brand'] == null
        //     ? null
        //     : Brand.fromMap(data['brand'] as Map<String, dynamic>),
        ratingsAverage: (data['ratingsAverage'] as num?)?.toDouble(),
        // createdAt: data['createdAt'] == null
        //     ? null
        //     : DateTime.parse(data['createdAt'] as String),
        // updatedAt: data['updatedAt'] == null
        //     ? null
        //     : DateTime.parse(data['updatedAt'] as String),
        // priceAfterDiscount: data['priceAfterDiscount'] as int?,
        // availableColors: data['availableColors'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        // 'sold': sold,
        // 'images': images,
        // 'ratingsQuantity': ratingsQuantity,
        // '_id': id,
        'title': title,
        // 'slug': slug,
        // 'description': description,
        // 'quantity': quantity,
        'price': price,
        'imageCover': imageCover,
        // 'category': category?.toMap(),
        // 'brand': brand?.toMap(),
        'ratingsAverage': ratingsAverage,
        // 'createdAt': createdAt?.toIso8601String(),
        // 'updatedAt': updatedAt?.toIso8601String(),
        // 'id': id,
        // 'priceAfterDiscount': priceAfterDiscount,
        // 'availableColors': availableColors,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  productsDataDto toProductsDataDto() {
    return productsDataDto(
        title: title,
        imageCover: imageCover,
        price: price,
        ratingsAverage: ratingsAverage);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());
}
