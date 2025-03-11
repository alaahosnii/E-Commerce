import 'dart:convert';

import 'cart.dart';

class AddToCartResponse {
  String? status;
  String? message;
  int? numOfCartItems;
  String? cartId;
  Cart? cart;

  AddToCartResponse({
    this.status,
    this.message,
    this.numOfCartItems,
    this.cartId,
    this.cart,
  });

  factory AddToCartResponse.fromMap(Map<String, dynamic> data) {
    return AddToCartResponse(
      status: data['status'] as String?,
      message: data['message'] as String?,
      numOfCartItems: data['numOfCartItems'] as int?,
      cartId: data['cartId'] as String?,
      cart: data['data'] == null
          ? null
          : Cart.fromMap(data['data'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'numOfCartItems': numOfCartItems,
        'cartId': cartId,
        'data': cart?.toMap(),
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddToCartResponse].
  factory AddToCartResponse.fromJson(String data) {
    return AddToCartResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddToCartResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
