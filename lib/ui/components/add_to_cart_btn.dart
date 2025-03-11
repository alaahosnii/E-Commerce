import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AddToCartBtn extends StatelessWidget {
  String? productId;
  AddToCartBtn({super.key, required this.productId});

  @override
  Widget build(BuildContext context) {
    var remoteCartCubit = RemoteCartCubit();
    var localCartCubit = context.read<LocalCartCubit>();
    return BlocConsumer(
      bloc: remoteCartCubit,
      listenWhen: (previous, current) {
        if (current is AddToRemoteCartLoading ||
            current is AddToRemoteCartError ||
            current is AddToRemoteCartSuccess) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state is AddToRemoteCartSuccess) {
          localCartCubit.addToCart(state.addToCartResponse!);
        }
      },
      builder: (context, state) {
        bool isLoading = state is AddToRemoteCartLoading;
        return isLoading
            ? CircularProgressIndicator()
            : Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: WidgetStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      backgroundColor: WidgetStatePropertyAll(
                        Color.fromRGBO(0, 65, 130, 1),
                      ),
                    ),
                    onPressed: () {
                      remoteCartCubit.addToCart(
                        productId: productId,
                      );
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/add_cart.png",
                          width: 24,
                          height: 24,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            "Add to cart",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
