import 'dart:async';
import 'dart:io';

import 'package:ecommerce/data/add_to_favorite_response.dart';
import 'package:ecommerce/data/api/add_cart_response/add_to_cart_response/add_to_cart_response.dart';
import 'package:ecommerce/data/api/cart_response/cart_response.dart';
import 'package:ecommerce/data/api/categories_response/categories_response.dart';
import 'package:ecommerce/data/api/favorite_response/favorite_response.dart';
import 'package:ecommerce/data/api/interceptor/LoggingInterceptor.dart';
import 'package:ecommerce/data/api/login_request.dart';
import 'package:ecommerce/data/api/login_response/login_response.dart';
import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/data/api/registrationRequest.dart';
import 'package:ecommerce/domain/customException/custom_exception.dart';
import 'package:ecommerce/domain/customException/network_exception.dart';
import 'package:ecommerce/data/api/products_response/products_response.dart';
import 'package:ecommerce/domain/datasource/favorites_response_dto.dart';
import 'package:ecommerce/domain/model/categories_data_dto.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_interceptor/http/intercepted_client.dart';

class ApiManager {
  static const String baseUrl = 'ecommerce.routemisr.com';
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

  Future<ProductsResponse> getAllProducts(
      {int? page = 1, String? category}) async {
    var url = Uri.https(
      baseUrl,
      'api/v1/products',
      {
        'page': page.toString(),
        if (category != null) "category": category,
      },
    );
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

  Future<CategoriesResponse> getSubCategories(String id) async {
    var url = Uri.https(baseUrl, "api/v1/categories/$id/subcategories");
    var response = await client.get(url);
    var categoriesResponse = CategoriesResponse.fromJson(response.body);

    return categoriesResponse;
  }

  Future<CartResponse> addToCart({String? productId}) async {
    print("productId: $productId");
    var url = Uri.https(baseUrl, "api/v1/cart");
    var response = await client.post(
      url,
      body: {
        "productId": productId,
      },
    );

    var addToCartResponse = CartResponse.fromJson(response.body);

    return addToCartResponse;
  }

  Future<CartResponse> getUserCart() async {
    var url = Uri.https(baseUrl, "api/v1/cart");
    var response = await client.get(
      url,
    );

    var cartResponse = CartResponse.fromJson(response.body);

    return cartResponse;
  }

  Future<CartResponse> deleteFromCart({String? id}) async {
    var url = Uri.https(baseUrl, "api/v1/cart/$id");
    var response = await client.delete(url);

    var cartResponse = CartResponse.fromJson(response.body);

    return cartResponse;
  }

  Future<CartResponse> updateProductQuantity(
      {String? id, String? quantity}) async {
    var url = Uri.https(baseUrl, "api/v1/cart/$id");
    var response = await client.put(url, body: {
      "count": quantity,
    });

    var cartResponse = CartResponse.fromJson(response.body);

    return cartResponse;
  }

  Future<AddToFavoriteResponse> addToFavorite({String? productId}) async {
    var url = Uri.https(baseUrl, "api/v1/wishlist");
    var response = await client.post(
      url,
      body: {
        "productId": productId,
      },
    );

    var addToFavoriteResponse = AddToFavoriteResponse.fromJson(response.body);

    return addToFavoriteResponse;
  }

  Future<FavoriteResponseDto> getFavorite() async {
    var url = Uri.https(baseUrl, "api/v1/wishlist");
    var response = await client.get(
      url,
    );

    var favoriteResponse = FavoriteResponse.fromJson(response.body);

    return favoriteResponse.toDto();
  }

  Future<AddToFavoriteResponse> removeFromFavorite({String? productId}) async {
    var url = Uri.https(baseUrl, "api/v1/wishlist/$productId");
    var response = await client.delete(
      url,
    );

    var addToFavoriteResponse = AddToFavoriteResponse.fromJson(response.body);

    return addToFavoriteResponse;
  }
}
