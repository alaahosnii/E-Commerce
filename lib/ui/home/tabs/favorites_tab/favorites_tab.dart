import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/ui/components/favorite_product.dart';
import 'package:ecommerce/ui/home/tabs/favorites_tab/favorites_tab_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesTab extends StatefulWidget {
  const FavoritesTab({super.key});

  @override
  State<FavoritesTab> createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  bool isLoading = false;
  List<ProductsDataDto> products = [];

  @override
  void initState() {
    super.initState();
    context.read<FavoritesTabCubit>().getFavorite();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoritesTabCubit, FavoritesTabState>(
      listener: (context, state) {
        if (state is FavoritesTabLoaded) {
          products = state.favorites!;
        }
        if (state is RemoveFromFavoriteSuccess) {
          print('remove from favorite');
          if (state.addToFavoriteResponse!.data!.isNotEmpty) {
            state.addToFavoriteResponse?.data?.forEach((id) {
              products.removeWhere((product) => product.id != id);
            });
          } else {
            products = [];
          }
        }
      },
      builder: (context, state) {
        isLoading =
            state is FavoritesTabLoading || state is RemoveFromFavoriteLoading;
        return Stack(
          alignment: Alignment.center,
          children: [
            products.isNotEmpty
                ? ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) =>
                        FavoriteProduct(product: products[index]),
                  )
                : !isLoading
                    ? const Center(child: Text('No favorites'))
                    : Container(),
            if (isLoading) CircularProgressIndicator(),
          ],
        );
      },
    );
  }
}
