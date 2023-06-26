import 'package:flutter/material.dart';

import '../../utils/validation_utils.dart';
import '../components/custom_text_field.dart';

class RegisterScreen extends StatefulWidget {
  static const String routeName = "Register";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  var formKey = GlobalKey<FormState>();

  var nameController = TextEditingController(text: '');

  var emailController = TextEditingController(text: '');

  var passwordController = TextEditingController(text: '');

  var passwordConfirmationController = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
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
                    CustomFormField(
                      controller: nameController,
                      label: 'Full Name',
                      hint: 'Enter Your Full Name',
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter full name';
                        }
                      },
                    ),
                    CustomFormField(
                      controller: emailController,
                      label: 'Mobile Number',
                      hint: 'Enter Your Mobile Number',
                      keyboardType: TextInputType.phone,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email';
                        }
                        if (!ValidationUtils.isValidEmail(text)) {
                          return 'please enter a valid email';
                        }
                      },
                    ),
                    CustomFormField(
                      controller: emailController,
                      label: 'Email Address',
                      hint: 'Enter Your Email',
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) {
                        if (text == null || text.trim().isEmpty) {
                          return 'please enter email';
                        }
                        if (!ValidationUtils.isValidEmail(text)) {
                          return 'please enter a valid email';
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
                                color: Theme.of(context).primaryColor, width: 1),
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12)),
                        onPressed: () {
                          register();
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 24,
                              color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void register() async {
    // async - await
    if (formKey.currentState?.validate() == false) {
      return;
    }
  }
}
