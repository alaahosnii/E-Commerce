import 'dart:convert';

import 'data.dart';

class CartResponse {
  String? status;
  int? numOfCartItems;
  String? message;
  String? cartId;
  Cart? cart;

  CartResponse(
      {this.status, this.numOfCartItems, this.message, this.cartId, this.cart});

  factory CartResponse.fromMap(Map<String, dynamic> data) => CartResponse(
        status: data['status'] as String?,
        numOfCartItems: data['numOfCartItems'] as int?,
        cartId: data['cartId'] as String?,
        message: data['message'] as String?,
        cart: data['data'] == null
            ? null
            : Cart.fromMap(data['data'] as Map<String, dynamic>),
      );

  // Map<String, dynamic> toMap() => {
  //       'status': status,
  //       'numOfCartItems': numOfCartItems,
  //       'cartId': cartId,
  //       'message': message,
  //       'data': cart?.toMap(),
  //     };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CartResponse].
  factory CartResponse.fromJson(String data) {
    return CartResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CartResponse] to a JSON string.
  // String toJson() => json.encode(toMap());
}
