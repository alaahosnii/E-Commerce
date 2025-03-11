import 'package:ecommerce/cubits/local_cart_cubit.dart';
import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/providers/auth_provider.dart';
import 'package:ecommerce/ui/home/home_screen.dart';
import 'package:ecommerce/ui/login/login_screen.dart';
import 'package:ecommerce/ui/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "Splash";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ApiManager apiManager = ApiManager();
  @override
  Widget build(BuildContext context) {
    var localCartCubit = context.read<LocalCartCubit>();
    return BlocListener<UserProvider, CurrentUserState>(
      listener: (context, state) {
        if (state is LoggedInState) {
          apiManager.getUserCart().then((response) {
            localCartCubit.addToCart(response);
            Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          });
        } else if (state is LoggedOutState) {
          Future.delayed(Duration(seconds: 2)).then((value) =>
              Navigator.pushReplacementNamed(context, LoginScreen.routeName));
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Image.asset(
          "assets/images/splash.png",
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
