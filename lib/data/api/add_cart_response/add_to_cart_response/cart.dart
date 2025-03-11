import 'dart:convert';

import 'product.dart';

class Cart {
  String? id;
  String? cartOwner;
  List<Product>? products;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? totalCartPrice;

  Cart({
    this.id,
    this.cartOwner,
    this.products,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.totalCartPrice,
  });

  factory Cart.fromMap(Map<String, dynamic> data) => Cart(
        id: data['_id'] as String?,
        cartOwner: data['cartOwner'] as String?,
        products: (data['products'] as List<dynamic>?)
            ?.map((e) => Product.fromMap(e as Map<String, dynamic>))
            .toList(),
        createdAt: data['createdAt'] == null
            ? null
            : DateTime.parse(data['createdAt'] as String),
        updatedAt: data['updatedAt'] == null
            ? null
            : DateTime.parse(data['updatedAt'] as String),
        v: data['__v'] as int?,
        totalCartPrice: data['totalCartPrice'] as int?,
      );

  Map<String, dynamic> toMap() => {
        '_id': id,
        'cartOwner': cartOwner,
        'products': products?.map((e) => e.toMap()).toList(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        '__v': v,
        'totalCartPrice': totalCartPrice,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Cart.fromJson(String data) {
    return Cart.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Cart copyWith({
    String? id,
    String? cartOwner,
    List<Product>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    int? totalCartPrice,
  }) {
    return Cart(
      id: id ?? this.id,
      cartOwner: cartOwner ?? this.cartOwner,
      products: products ?? this.products,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      totalCartPrice: totalCartPrice ?? this.totalCartPrice,
    );
  }
}
