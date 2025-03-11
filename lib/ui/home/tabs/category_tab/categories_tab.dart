import 'package:ecommerce/data/api/products_response/subcategory.dart';
import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:ecommerce/providers/categories_list_provider.dart';
import 'package:ecommerce/ui/components/category_card.dart';
import 'package:ecommerce/ui/components/category_img.dart';
import 'package:ecommerce/ui/components/sub_category_card.dart';
import 'package:ecommerce/ui/home/tabs/category_tab/categories_tab_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class CategoriesTab extends StatefulWidget {
  CategoriesTab({super.key});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {
  int selectedTabIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<CategoriesDataDto> categories =
        Provider.of<CategoriesListProvider>(context).categories;
    print(categories);

    return BlocProvider(
      create: (context) =>
          CategoriesTabViewmodel()..getCategories(id: categories[0].id!),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 137,
              height: double.infinity,
              margin: EdgeInsets.only(left: 10),
              decoration: const BoxDecoration(
                color: Color.fromRGBO(219, 228, 237, 0.5),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                ),
                border: Border(
                  left: BorderSide(color: Colors.blue),
                  top: BorderSide(color: Colors.blue),
                ),
              ),
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        selectedTabIndex = index;
                      });
                      BlocProvider.of<CategoriesTabViewmodel>(context)
                          .getCategories(id: categories[selectedTabIndex].id!);
                    },
                    child: CategoryCard(
                      title: categories[index].name,
                      isSelected: selectedTabIndex == index,
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categories[selectedTabIndex].name!,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    BlocBuilder<CategoriesTabViewmodel, CategoriesTabViewState>(
                      builder: (context, state) {
                        if (state is CategoriesTabLoading) {
                          return CircularProgressIndicator();
                        } else if (state is CategoriesTabLoaded) {
                          if (state.categories.isEmpty) {
                            return Container(
                              child: Center(
                                child: Text(
                                  'No categories found',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(top: 15),
                                child: GridView.builder(
                                  itemCount: state.categories.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3,
                                    childAspectRatio: .6,
                                    crossAxisSpacing: 0,
                                    mainAxisSpacing: 0,
                                  ),
                                  itemBuilder: (context, index) =>
                                      SubCategoryCard(
                                    id: state.categories[index].category,
                                    name: state.categories[index].name,
                                    image: categories
                                        .firstWhere((element) =>
                                            element.id ==
                                            state.categories[index].category)
                                        .image!,
                                  ),
                                ),
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      },
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
