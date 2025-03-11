import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/cubits/remote_cart_cubit.dart';
import 'package:ecommerce/providers/auth_provider.dart';
import 'package:ecommerce/providers/categories_list_provider.dart';
import 'package:ecommerce/providers/favorites_provider.dart';
import 'package:ecommerce/ui/cart/cart_screen.dart';
import 'package:ecommerce/ui/home/home_screen.dart';
import 'package:ecommerce/ui/home/tabs/favorites_tab/favorites_tab_cubit.dart';
import 'package:ecommerce/ui/home/tabs/products_tab/products_tab.dart';
import 'package:ecommerce/ui/login/login_screen.dart';
import 'package:ecommerce/ui/my_theme.dart';
import 'package:ecommerce/ui/product_details/product_details.dart';
import 'package:ecommerce/ui/register/register_screen.dart';
import 'package:ecommerce/ui/splash/splash_screen.dart';
import 'package:ecommerce/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter binding

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserProvider(),
          ),
          BlocProvider(
            create: (context) => RemoteCartCubit(),
          ),
          BlocProvider(
            create: (context) => LocalCartCubit(),
          ),
          ChangeNotifierProvider(
            create: (context) => CategoriesListProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => UserFavoritesProvider(),
          ),
          BlocProvider(
            create: (context) => FavoritesTabCubit(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: MyTheme.primaryColor,
          ),
          initialRoute: SplashScreen.routeName,
          routes: {
            SplashScreen.routeName: (_) => SplashScreen(),
            RegisterScreen.routeName: (_) => RegisterScreen(),
            LoginScreen.routeName: (_) => LoginScreen(),
            HomeScreen.routeName: (_) => HomeScreen(),
            ProductsTab.routeName: (_) => ProductsTab(),
            ProductDetails.routeName: (_) => ProductDetails(),
            CartScreen.routeName: (_) => CartScreen(),
          },
        ));
  }
}
