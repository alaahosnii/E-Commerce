import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/local_cart_cubit_state.dart';
import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:ecommerce/data/api/cart_response/product.dart';
import 'package:ecommerce/ui/components/cart_product.dart';
import 'package:ecommerce/ui/components/checkout_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatefulWidget {
  static const routeName = "cart";
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool isLoading = true;
  List<Product> products = [];
  int totalCartPrice = 0;
  @override
  Widget build(BuildContext context) {
    context.read<RemoteCartCubit>().getCart();
    var localCartCubit = context.read<LocalCartCubit>();
    return BlocConsumer<RemoteCartCubit, RemoteCartState>(
      listener: (context, state) {
        if (state is GetRemoteCartSuccess) {
          products = [...state.cartResponse!.cart!.products!];
          totalCartPrice = state.cartResponse!.cart!.totalCartPrice!;
          isLoading = false;
        }
        if (state is DeleteFromRemoteCartLoadingState) {
          isLoading = true;
        }
        if (state is DeleteFromRemoteCartSuccessState) {
          isLoading = false;
          products = [...state.cartResponse!.cart!.products!];
          localCartCubit.addToCart(state.cartResponse!);
          totalCartPrice = state.cartResponse!.cart!.totalCartPrice!;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Deleted from cart"),
            ),
          );
        }
        if (state is UpdateProductQuantityLoadingState) {
          isLoading = true;
        }
        if (state is UpdateProductQuantitySuccessState) {
          isLoading = false;
          products = [...state.cartResponse!.cart!.products!];
          totalCartPrice = state.cartResponse!.cart!.totalCartPrice!;
          localCartCubit.addToCart(state.cartResponse!);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: true,
            iconTheme: IconThemeData(
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              "Cart",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          body: Stack(
            alignment: Alignment.center,
            children: [
              Column(
                children: [
                  Expanded(
                    flex: 9,
                    child: products.isNotEmpty
                        ? ListView.builder(
                            itemCount: products.length,
                            itemBuilder: (context, index) {
                              return CartProduct(product: products[index]);
                            })
                        : const Center(
                            child: Text("No products in cart"),
                          ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Total Price",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 18,
                                  // fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "EGP $totalCartPrice",
                                style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        CheckoutBtn()
                      ],
                    ),
                  )
                ],
              ),
              if (isLoading) const CircularProgressIndicator()
            ],
          ),
        );
      },
    );
  }
}
