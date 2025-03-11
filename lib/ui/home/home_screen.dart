import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/local_cart_cubit_state.dart';
import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:ecommerce/providers/favorites_provider.dart';
import 'package:ecommerce/ui/cart/cart_screen.dart';
import 'package:ecommerce/ui/home/bottom_nav_icon.dart';
import 'package:ecommerce/ui/home/tabs/category_tab/categories_tab.dart';
import 'package:ecommerce/ui/home/tabs/favorites_tab/favorites_tab.dart';
import 'package:ecommerce/ui/home/tabs/favorites_tab/favorites_tab_cubit.dart';
import 'package:ecommerce/ui/home/tabs/home_tab/home_tab.dart';
import 'package:ecommerce/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'Home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var searchController = TextEditingController(text: '');
  var selectedIndex = 0;
  var isSelected = false;
  var tabs = [HomeTab(), CategoriesTab(), FavoritesTab()];
  @override
  Widget build(BuildContext context) {
    return BlocListener<FavoritesTabCubit, FavoritesTabState>(
      listener: (context, state) {
        print("state from listener: $state");
        if (state is AddToFavoriteError) {
          DialogUtils.getDialog("Error", state.errorMessage, context);
        }
        if (state is AddToFavoriteSuccess) {
          print("added to favorite");
          state.addToFavoriteResponse?.data?.forEach((id) {
            context.read<UserFavoritesProvider>().addFavorite(productId: id);
          });
        }
        if (state is RemoveFromFavoriteSuccess) {
          context.read<UserFavoritesProvider>().removeFromFavorite(
              updatedFavorites: state.addToFavoriteResponse!.data!);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        fontSize: 15, color: Theme.of(context).primaryColor),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Theme.of(context).primaryColor),
                        borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),
              BlocListener<RemoteCartCubit, RemoteCartState>(
                listenWhen: (previous, current) {
                  if (current is AddToRemoteCartSuccess) {
                    return true;
                  }
                  return false;
                },
                listener: (context, state) {
                  if (state is AddToRemoteCartSuccess) {
                    context
                        .read<LocalCartCubit>()
                        .addToCart(state.addToCartResponse!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text("${state.addToCartResponse!.message}")),
                    );
                  }
                },
                child: InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, CartScreen.routeName),
                  child: Badge(
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
                  ),
                ),
              )
            ],
          ),
        ),
        body: tabs[selectedIndex],
        bottomNavigationBar: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          child: SizedBox(
            height: 77,
            child: BottomNavigationBar(
              iconSize: 24,
              selectedFontSize: 0,
              unselectedFontSize: 0,
              backgroundColor: Theme.of(context).primaryColor,
              currentIndex: selectedIndex,
              type: BottomNavigationBarType.fixed,
              onTap: (index) {
                selectedIndex = index;
                setState(() {});
              },
              items: [
                BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: BottomNavIcon('home', selectedIndex == 0),
                    label: ''),
                BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: BottomNavIcon('categories', selectedIndex == 1),
                    label: ''),
                BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: BottomNavIcon('wish', selectedIndex == 2),
                    label: ''),
                BottomNavigationBarItem(
                    backgroundColor: Theme.of(context).primaryColor,
                    icon: BottomNavIcon('profile', selectedIndex == 3),
                    label: ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
