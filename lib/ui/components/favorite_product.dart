import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/ui/home/tabs/favorites_tab/favorites_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteProduct extends StatefulWidget {
  ProductsDataDto product;
  FavoriteProduct({super.key, required this.product});

  @override
  State<FavoriteProduct> createState() => _FavoriteProductState();
}

class _FavoriteProductState extends State<FavoriteProduct> {
  @override
  Widget build(BuildContext context) {
    var remoteCartCubit = context.read<RemoteCartCubit>();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color.fromRGBO(0, 65, 130, 0.3)),
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Color.fromRGBO(0, 65, 130, 0.3)),
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                child: Image.network(
                  widget.product.imageCover!,
                  width: 120,
                  height: 113,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              child: Container(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 250,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 200,
                            child: Text(
                              widget.product.title!,
                              maxLines: 1,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () => context
                                .read<FavoritesTabCubit>()
                                .removeFromFavorite(
                                  productId: widget.product.id,
                                ),
                            child: Image.asset(
                              'assets/images/fav_filled.png',
                              width: 40,
                              // height: 50,
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
                          InkWell(
                            onTap: () => remoteCartCubit.addToCart(
                              productId: widget.product.id,
                            ),
                            child: Container(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 7, bottom: 7),
                              decoration: BoxDecoration(
                                color: const Color.fromRGBO(0, 65, 130, 1),
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: const Text("Add to cart",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ),
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
