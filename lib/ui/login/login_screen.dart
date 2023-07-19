import 'package:ecommerce/providers/auth_provider.dart';
import 'package:ecommerce/ui/home/home_screen.dart';
import 'package:ecommerce/ui/register/register_screen.dart';
import 'package:ecommerce/utils/dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/validation_utils.dart';
import '../components/custom_text_field.dart';
import 'login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = "Login";

  @override
  State<LoginScreen> createState() => _LoginScreenScreenState();
}

class _LoginScreenScreenState extends State<LoginScreen> {
  var formKey = GlobalKey<FormState>();

  var emailController = TextEditingController(text: '');

  var passwordController = TextEditingController(text: '');

  var loginViewModel = LoginViewModel();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginViewModel, LoginViewState>(
      bloc: loginViewModel,
      buildWhen: (previous, current) {
        if (current is LoginInitialState) {
          return true;
        }
        return false;
      },
      listenWhen: (previous, current) {
        if (previous is LoginLoadingState) {
          DialogUtils.hideDialog(context);
        }
        if (current is LoginLoadingState ||
            current is LoginFailState ||
            current is LoginSuccessState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state is LoginLoadingState) {
          DialogUtils.getDialog(
              state.loadingMessage, state.loadingMessage, context);
        } else if (state is LoginFailState) {
          DialogUtils.getDialog(state.failMessage, state.failContent, context);
        } else if (state is LoginSuccessState) {
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
          UserProvider userProvider =
              BlocProvider.of<UserProvider>(context, listen: false);
          userProvider.login(LoggedInState(
              user: state.loginResponse.userDto!,
              token: state.loginResponse.token!));
        }
      },
      builder: (BuildContext context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xFFFFFFFF),
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  SizedBox(height: 90),
                  Image.asset('images/route_logo.png'),
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .07,
                        ),
                        Text(
                          'Welcome Back To Route',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Please sign in with your mail',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 25),
                        CustomFormField(
                          controller: emailController,
                          label: 'Email Address',
                          hint: 'Enter Your Email',
                          keyboardType: TextInputType.emailAddress,
                          validator: (email) {
                            if (email == null || email.trim().isEmpty) {
                              return 'please enter email';
                            }
                            if (!ValidationUtils.isValidEmail(email)) {
                              return 'please enter email';
                            }
                          },
                        ),
                        CustomFormField(
                          controller: passwordController,
                          label: 'Password',
                          hint: 'Enter Your Password',
                          keyboardType: TextInputType.text,
                          isPassword: true,
                          validator: (text) {
                            if (text == null || text.trim().isEmpty) {
                              return 'please enter password';
                            }
                            if (text.length < 6) {
                              return 'password should at least 6 chars';
                            }
                          },
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(double.infinity, 60),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                side: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 1),
                                backgroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 12)),
                            onPressed: () {
                              login();
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(
                                  fontSize: 24,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            margin: const EdgeInsets.only(top: 30),
                            child: TextButton(
                              style: const ButtonStyle(
                                  overlayColor:
                                      MaterialStatePropertyAll(Colors.grey)),
                              child: Text(
                                'Don’t have an account? Create Account',
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Theme.of(context).primaryColor),
                              ),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, RegisterScreen.routeName);
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void login() async {
    // async - await
    if (formKey.currentState?.validate() == false) {
      return;
    }
    loginViewModel.login(emailController.text, passwordController.text);
  }
}
