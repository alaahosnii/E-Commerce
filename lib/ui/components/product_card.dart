import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/providers/favorites_provider.dart';
import 'package:ecommerce/ui/home/tabs/favorites_tab/favorites_tab_cubit.dart';
import 'package:ecommerce/ui/home/tabs/products_tab/products_tab.dart';
import 'package:ecommerce/ui/product_details/product_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductCard extends StatefulWidget {
  ProductsDataDto product;
  ProductCard({required this.product, Key? key}) : super(key: key);

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, ProductDetails.routeName,
          arguments: widget.product),
      child: Container(
        width: 160,
        margin: EdgeInsets.only(top: 20, left: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Stack(
              alignment: Alignment.topRight,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                  child: Image.network(
                    widget.product.imageCover!,
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                Consumer<UserFavoritesProvider>(
                  builder: (BuildContext context, provider, Widget? child) {
                    bool isFavorite =
                        provider.favorites.contains(widget.product.id);
                    return InkWell(
                      onTap: () => isFavorite
                          ? context
                              .read<FavoritesTabCubit>()
                              .removeFromFavorite(productId: widget.product.id)
                          : context
                              .read<FavoritesTabCubit>()
                              .addToFavorite(productId: widget.product.id),
                      child: Image.asset(
                        'assets/images/${isFavorite ? "fav_filled" : "wishBtn"}.png',
                        width: 50,
                      ),
                    );
                  },
                )
              ],
            ),
            SizedBox(
              height: 3,
            ),
            Expanded(
              child: Container(
                // height: 50,
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.product.title!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Review (${widget.product.ratingsAverage})',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'EGP ${widget.product.price.toString()}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
