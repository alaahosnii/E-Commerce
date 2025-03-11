import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/local_cart_cubit_state.dart';
import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:ecommerce/data/api/cart_response/product.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/ui/components/quantity_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartProduct extends StatefulWidget {
  Product product;
  CartProduct({super.key, required this.product});

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  @override
  Widget build(BuildContext context) {
    var remoteCartCubit = context.read<RemoteCartCubit>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).primaryColor),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  widget.product.cartProduct!.imageCover!,
                  width: 120,
                  height: 113,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 90,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              widget.product.cartProduct!.title!,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => remoteCartCubit.deleteFromCart(
                                productId: widget.product.cartProduct!.id),
                            child: Image.asset(
                              'assets/images/delete.png',
                              width: 25,
                              height: 25,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "EGP ${widget.product.price.toString()}",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          QuantityCard(
                            changeQuantity: (value) {
                              remoteCartCubit.updateProductQuantity(
                                id: widget.product.cartProduct!.id,
                                quantity: value.toString(),
                              );
                              // setState(() {});
                            },
                            quantity: widget.product.count!,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
