import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/ui/home/tabs/categories_tab.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/category_img.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/home_tab_model.dart';
import 'package:ecommerce/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  var viewModel = HomeTabViewModel();
  var imagesList = [
    Image.asset('images/sliderImage.png'),
    Image.asset('images/sliderImage.png'),
    Image.asset('images/sliderImage.png'),
  ];
  List<CategoriesDataDto> categoriesList = [];
  List<productsDataDto>? productsList;

  @override
  Widget build(BuildContext context) {
    // viewModel.getCategories();
    // viewModel.getAllProducts();
    return BlocConsumer<HomeTabViewModel, HomeTabViewState>(
      bloc: viewModel
        ..getCategories()
        ..getAllProducts(),
      listener: (context, state) {
        if (state is HomeTabLoadingState) {
          DialogUtils.getDialog('Loading', state.loadingMessage, context);
        }
      },
      builder: (BuildContext context, state) {
        if (state is HomeTabSuccessState) {
          categoriesList = state.categories;
          // setState(() {});
        } else if (state is HomeTabProductsSuccess) {
          productsList = state.products;
          // setState(() {});
        }
        return SingleChildScrollView(
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
                  margin: EdgeInsets.only(top: 10),
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
                  width: double.infinity,
                  height: 210,
                  child: GridView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: categoriesList.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 30),
                    itemBuilder: (context, index) =>
                        CategoryIcon(categoriesList[index].image!),
                  ),
                ),
                productsList != null
                    ? Container(
                        width: double.infinity,
                        height: 260,
                        child: ListView.builder(
                          itemCount: 20,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Container(
                              width: 130,
                              margin: EdgeInsets.only(top: 20, left: 10),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Stack(
                                    alignment: Alignment.topRight,
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20)),
                                        child: Image.network(
                                          productsList![index].imageCover!,
                                          width: 150,
                                          height: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Image.asset(
                                        'images/wishBtn.png',
                                        width: 40,
                                      )
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      productsList![index].title!,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 13,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Review (${productsList![index].ratingsAverage})',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'EGP ${productsList![index].price.toString()}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
