import 'package:ecommerce/cubits/local_cart_cubit_state.dart';
import 'package:ecommerce/data/api/cart_response/cart_response.dart';
import 'package:ecommerce/data/api/cart_response/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalCartCubit extends Cubit<LocalCartCubitState> {
  LocalCartCubit() : super(LocalCartCubitInitState());

  void addToCart(CartResponse response) {
    emit(AddToCartSuccessState(
      id: response.cartId,
      cartOwner: response.cart!.cartOwner,
      products: response.cart!.products,
      createdAt: response.cart!.createdAt,
      updatedAt: response.cart!.updatedAt,
      v: response.cart!.v,
      totalCartPrice: response.cart!.totalCartPrice,
    ));
  }

  // void removeFromCart({String? id}) {
  //   int price = (state as AddToCartSuccessState).totalCartPrice!;

  //   print("remove from cart $id");
  //   if (state is AddToCartSuccessState) {
  //     List<Product> products = [...(state as AddToCartSuccessState).products!];
  //     print("${products[0].cartProduct!.id}");
  //     int deletedIndex =
  //         products.indexWhere((product) => product.cartProduct!.id == id);
  //     price -= products[deletedIndex].price!;
  //     products.removeWhere((product) => product.cartProduct!.id == id);
  //     print("products: $products");
  //     emit(DeleteFromCartSuccessState(
  //         products: products, totalCartPrice: price));
  //   } else if (state is DeleteFromCartSuccessState) {
  //     List<Product> products = [
  //       ...(state as DeleteFromCartSuccessState).products!
  //     ];

  //     int deletedIndex =
  //         products.indexWhere((product) => product.cartProduct!.id == id);
  //     price -= products[deletedIndex].price!;
  //     products.removeWhere((product) => product.cartProduct!.id == id);
  //     print("products: $products");
  //     emit(DeleteFromCartSuccessState(
  //         products: products, totalCartPrice: price));
  //   }
  // }
}
