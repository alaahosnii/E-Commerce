import 'package:ecommerce/ui/my_theme.dart';
import 'package:ecommerce/ui/register/register_screen.dart';
import 'package:ecommerce/ui/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyTheme.primaryColor,
      ),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (_) => SplashScreen(),
        RegisterScreen.routeName: (_) => RegisterScreen()

      },
    );
  }
}
