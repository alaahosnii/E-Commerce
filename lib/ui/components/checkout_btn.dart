import 'package:flutter/material.dart';

class CheckoutBtn extends StatelessWidget {
  const CheckoutBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
            // remoteCartCubit.addToCart(
            //   productId: productId,
            // );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  "Checkout",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Image.asset(
                  "assets/images/arrow.png",
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
