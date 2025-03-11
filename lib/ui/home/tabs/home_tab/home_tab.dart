import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/providers/categories_list_provider.dart';
import 'package:ecommerce/providers/favorites_provider.dart';
import 'package:ecommerce/ui/components/product_card.dart';
import 'package:ecommerce/ui/home/tabs/category_tab/categories_tab.dart';
import 'package:ecommerce/ui/components/category_img.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/home_tab_model.dart';
import 'package:ecommerce/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var viewModel = HomeTabViewModel();
  var imagesList = [
    Image.asset('assets/images/sliderImage.png'),
    Image.asset('assets/images/sliderImage.png'),
    Image.asset('assets/images/sliderImage.png'),
  ];
  List<CategoriesDataDto> categoriesList = [];
  List<ProductsDataDto>? productsList;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeTabViewModel, HomeTabViewState>(
      bloc: viewModel
        ..getCategories()
        ..getAllProducts()
        ..getUserFavorites(),
      listener: (context, state) {
        if (state is HomeTabLoadingState) {
          DialogUtils.getDialog('Loading', state.loadingMessage, context);
        }
        if (state is HomeTabSuccessState) {
          categoriesList = state.categories;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Provider.of<CategoriesListProvider>(context, listen: false)
                .setCategoriesList(categoriesList);
          });
          // setState(() {});
        }
        if (state is HomeTabProductsSuccess) {
          productsList = state.products;
          // setState(() {});
        }
        if (state is GetUserFavoritesSuccessState) {
          print("favorites: ${state.products?.length}");
          state.products?.forEach((product) {
            Provider.of<UserFavoritesProvider>(context, listen: false)
                .addFavorite(productId: product.id);
          });
        }
      },
      builder: (BuildContext context, state) {
        return Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  ImageSlideshow(
                    width: 350,
                    height: MediaQuery.of(context).size.height * .23,
                    indicatorColor: Theme.of(context).primaryColor,
                    indicatorBackgroundColor: Colors.white,
                    children: imagesList,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            'Categories',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          child: Text(
                            'view all',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 170,
                    padding: EdgeInsets.all(5),
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: categoriesList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1,
                        crossAxisSpacing: 20,
                        mainAxisSpacing: 30,
                      ),
                      itemBuilder: (context, index) =>
                          CategoryIcon(categoriesList[index].image!),
                    ),
                  ),
                  productsList != null
                      ? Container(
                          height: 240,
                          child: ListView.builder(
                            itemCount: productsList!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return ProductCard(product: productsList![index]);
                            },
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
