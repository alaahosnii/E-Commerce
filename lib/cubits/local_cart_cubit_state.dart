import 'package:ecommerce/data/api/cart_response/cart_product/cart_product.dart';
import 'package:ecommerce/data/api/cart_response/product.dart';
import 'package:equatable/equatable.dart';

abstract class LocalCartCubitState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LocalCartCubitInitState extends LocalCartCubitState {
  @override
  List<Object?> get props => [];
}

class LocalCartCubitLoadingState extends LocalCartCubitState {
  @override
  List<Object?> get props => [];
}

class AddToCartSuccessState extends LocalCartCubitState {
  String? id;
  String? cartOwner;
  List<Product>? products;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;
  int? totalCartPrice;
  AddToCartSuccessState({
    required this.id,
    required this.cartOwner,
    required this.products,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.totalCartPrice,
  });
  @override
  List<Object?> get props => [
        id,
        cartOwner,
        products,
        createdAt,
        updatedAt,
        v,
        totalCartPrice,
      ];

  LocalCartCubitState copyWith({
    String? id,
    String? cartOwner,
    List<Product>? products,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? v,
    int? totalCartPrice,
  }) {
    return AddToCartSuccessState(
        id: id ?? this.id,
        cartOwner: cartOwner ?? this.cartOwner,
        products: products ?? this.products,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        v: v ?? this.v,
        totalCartPrice: totalCartPrice ?? this.totalCartPrice);
  }
}

class DeleteFromCartSuccessState extends LocalCartCubitState {
  List<Product>? products;
  int? totalCartPrice;
  DeleteFromCartSuccessState(
      {required this.products, required this.totalCartPrice});

  @override
  List<Object?> get props => [products];
}
