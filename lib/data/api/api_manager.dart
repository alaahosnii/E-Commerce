import 'dart:async';
import 'dart:io';

import 'package:ecommerce/data/api/categories_response/categories_response.dart';
import 'package:ecommerce/data/api/interceptor/LoggingInterceptor.dart';
import 'package:ecommerce/data/api/login_request.dart';
import 'package:ecommerce/data/api/login_response/login_response.dart';
import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/data/api/registrationRequest.dart';
import 'package:ecommerce/domain/customException/custom_exception.dart';
import 'package:ecommerce/domain/customException/network_exception.dart';
import 'package:ecommerce/data/api/products_response/products_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class ApiManager {
  static const String baseUrl = 'route-ecommerce.onrender.com';
  Client client = InterceptedClient.build(
    interceptors: [
      LoggingInterceptor(),
    ],
  );

  Future<CategoriesResponse> getCategories() async {
    var url = Uri.https(baseUrl, 'api/v1/categories');
    var response = await client.get(url);

    var categoriesResponse = CategoriesResponse.fromJson(response.body);

    return categoriesResponse;
  }

  Future<ProductsResponse> getAllProducts() async {
    var url = Uri.https(baseUrl, 'api/v1/products');
    var response = await client.get(url);

    var productsResponse = ProductsResponse.fromJson(response.body);

    return productsResponse;
  }

  Future<LoginRegisterResponse> register(
      {String? name,
      String? email,
      String? password,
      String? rePassword,
      String? phone}) async {
    var url = Uri.https(baseUrl, "api/v1/auth/signup");
    var requestBody = RegistrationRequest(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone);
    var response = await client.post(url, body: requestBody.toJson());
    var registerResponse = LoginRegisterResponse.fromJson(response.body);

    return registerResponse;
  }

  Future<LoginResponse> login(String email, String password) async {
    var url = Uri.https(baseUrl, "api/v1/auth/signin");
    var requestBody = LoginRequest(email: email, password: password);
    var response = await client.post(url, body: requestBody.toJson());
    var loginResponse = LoginResponse.fromJson(response.body);
    if (loginResponse.statusMessage == 'fail') {
      throw ServerError(loginResponse.message!);
    }
    return loginResponse;
  }
}
