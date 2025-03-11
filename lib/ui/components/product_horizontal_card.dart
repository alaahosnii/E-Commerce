import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/providers/favorites_provider.dart';
import 'package:ecommerce/ui/home/tabs/favorites_tab/favorites_tab_cubit.dart';
import 'package:ecommerce/ui/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ProductHorizontalCard extends StatefulWidget {
  ProductsDataDto product;
  ProductHorizontalCard({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductHorizontalCard> createState() => _ProductHorizontalCardState();
}

class _ProductHorizontalCardState extends State<ProductHorizontalCard> {
  bool isFavClicked = false;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final remoteCartCubit = context.read<RemoteCartCubit>();
    return BlocListener<FavoritesTabCubit, FavoritesTabState>(
      listenWhen: (previous, current) {
        if (isFavClicked) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state is AddToFavoriteSuccess ||
            state is RemoveFromFavoriteSuccess) {
          isLoading = false;
          isFavClicked = false;
        }
        if (state is AddToFavoriteLoading ||
            state is RemoveFromFavoriteLoading) {
          isLoading = true;
        }
      },
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, ProductDetails.routeName,
              arguments: widget.product);
        },
        child: Container(
          width: 191,
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            border: Border.all(
              color: Color.fromRGBO(0, 65, 130, 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: Image.network(
                      fit: BoxFit.cover,
                      widget.product.imageCover!,
                      height: 120,
                      width: double.infinity,
                    ),
                  ),
                  Consumer<UserFavoritesProvider>(
                    builder: (BuildContext context, provider, Widget? child) {
                      bool isFavorite =
                          provider.favorites.contains(widget.product.id);
                      return isLoading
                          ? Container(
                              margin: const EdgeInsets.only(right: 10, top: 10),
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: Colors.white,
                              ),
                              height: 30,
                              width: 30,
                              child: const CircularProgressIndicator(
                                color: Color.fromRGBO(0, 65, 130, 1),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                isFavorite
                                    ? context
                                        .read<FavoritesTabCubit>()
                                        .removeFromFavorite(
                                            productId: widget.product.id)
                                    : context
                                        .read<FavoritesTabCubit>()
                                        .addToFavorite(
                                            productId: widget.product.id);
                                setState(() {
                                  isFavClicked = true;
                                });
                              },
                              child: Image.asset(
                                'assets/images/${isFavorite ? "fav_filled" : "wishBtn"}.png',
                                width: 55,
                              ),
                            );
                    },
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.product.title!,
                          // maxLines: 2,
                          // overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          children: [
                            Text(
                              "EGP ${widget.product.priceAfterDiscount != null ? widget.product.priceAfterDiscount : widget.product.price}",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 14,
                              ),
                            ),
                            widget.product.priceAfterDiscount != null
                                ? Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      "EGP ${widget.product.price!}",
                                      style: const TextStyle(
                                        color: Color.fromRGBO(0, 65, 130, 0.6),
                                        fontSize: 14,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor:
                                            Color.fromRGBO(0, 65, 130, 0.6),
                                      ),
                                    ),
                                  )
                                : Container(),
                          ],
                        ),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                // height: 30,
                                child: Text(
                                  "Review (${widget.product.ratingsAverage})",
                                  style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Image.asset(
                                  "assets/images/star.png",
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () => remoteCartCubit.addToCart(
                                productId: widget.product.id),
                            child: Image.asset(
                              "assets/images/add_icon.png",
                              width: 30,
                              height: 30,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
