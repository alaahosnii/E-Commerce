import 'dart:convert';

import 'package:ecommerce/data/api/cart_response/cart_product/cart_product.dart';

import 'product.dart';

class Product {
  int? count;
  String? id;
  CartProduct? cartProduct;
  String? productId;
  int? price;

  Product({this.count, this.productId, this.id, this.cartProduct, this.price});

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        count: data['count'] as int?,
        id: data['_id'] as String?,
        cartProduct: data['product'] is Map<String, dynamic>
            ? CartProduct.fromMap(data["product"])
            : null,
        productId: data['product'] is String ? data["product"] : null,
        price: data['price'] as int?,
      );

  // Map<String, dynamic> toMap() => {
  //       'count': count,
  //       '_id': id,
  //       'product': product?.toMap(),
  //       'price': price,
  //     };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  // String toJson() => json.encode(toMap());
}
