import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/local_cart_cubit_state.dart';
import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:ecommerce/data/api/add_cart_response/add_to_cart_response/cart.dart';
import 'package:ecommerce/domain/model/products_data_dto.dart';
import 'package:ecommerce/ui/components/product_horizontal_card.dart';
import 'package:ecommerce/ui/home/tabs/products_tab/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsTab extends StatefulWidget {
  static const routeName = "ProductsTab";
  ProductsTab({Key? key}) : super(key: key);

  @override
  State<ProductsTab> createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  TextEditingController searchController = TextEditingController();
  late String categoryId;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    categoryId = args["id"];
    print("category id $categoryId");
    final localCartCubit = context.read<LocalCartCubit>();
    return BlocProvider(
      create: (context) => ProductsCubit()..getProducts(category: categoryId),
      child: BlocConsumer<RemoteCartCubit, RemoteCartState>(
        listenWhen: (previous, current) {
          if (current is AddToRemoteCartLoading) {
            return true;
          }

          return false;
        },
        listener: (context, state) {
          print("state: $state");
          if (state is AddToRemoteCartLoading) {
            isLoading = true;
          }
          // if (state is AddToRemoteCartSuccess) {
          //   print("add to cart success");
          //   isLoading = false;
          //   localCartCubit.addToCart(state.addToCartResponse!);
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     SnackBar(content: Text("${state.addToCartResponse!.message}")),
          //   );
          // }
        },
        buildWhen: (previous, current) {
          if (current is AddToRemoteCartLoading ||
              current is AddToRemoteCartError ||
              current is AddToRemoteCartSuccess) {
            return true;
          }
          return false;
        },
        builder: (context, state) {
          isLoading = state is AddToRemoteCartLoading;
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              // titleSpacing: 20,
              title: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Image.asset('assets/images/search.png'),
                        labelText: 'what do you search for?',
                        labelStyle: TextStyle(
                            fontSize: 15,
                            color: Theme.of(context).primaryColor),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(30)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).primaryColor),
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  Badge(
                    label: BlocBuilder<LocalCartCubit, LocalCartCubitState>(
                      builder: (context, state) {
                        if (state is AddToCartSuccessState) {
                          return Text(
                            state.products != null
                                ? state.products!.length.toString()
                                : "0",
                            style: TextStyle(fontSize: 15),
                          );
                        } else {
                          return Text(
                            "0",
                            style: TextStyle(fontSize: 15),
                          );
                        }
                      },
                    ),
                    largeSize: 20,
                    offset: Offset(5, -15),
                    child: Container(
                      margin: const EdgeInsets.only(left: 10),
                      child: ImageIcon(
                        size: 26,
                        const AssetImage('assets/images/shopping_cart.png'),
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
                bottom: false,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BlocBuilder<ProductsCubit, ProductsViewState>(
                      builder: (context, state) {
                        if (state is ProductsLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else if (state is ProductsLoaded) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GridView.builder(
                              itemCount: state.products!.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                childAspectRatio: .78,
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                              ),
                              itemBuilder: (context, index) =>
                                  ProductHorizontalCard(
                                product: state.products[index],
                              ),
                            ),
                          );
                        }
                        return Container();
                      },
                    ),
                    if (isLoading) CircularProgressIndicator()
                  ],
                )),
          );
        },
      ),
    );
  }
}
