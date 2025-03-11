import 'dart:convert';

class Product {
  int? count;
  String? id;
  String? product;
  int? price;

  Product({this.count, this.id, this.product, this.price});

  factory Product.fromMap(Map<String, dynamic> data) => Product(
        count: data['count'] as int?,
        id: data['_id'] as String?,
        product: data['product'] as String?,
        price: data['price'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'count': count,
        '_id': id,
        'product': product,
        'price': price,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Product].
  factory Product.fromJson(String data) {
    return Product.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Product] to a JSON string.
  String toJson() => json.encode(toMap());
}
