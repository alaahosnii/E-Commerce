import 'package:ecommerce/ui/register/register_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  static const String routeName = "Splash";

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2) , (){
      Navigator.pushReplacementNamed(context, RegisterScreen.routeName);
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Image.asset(
        "images/splash.png",
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }
}
