import 'dart:convert';

import 'package:ecommerce/domain/model/auth_response_dto.dart';
import 'package:ecommerce/domain/model/auth_user_dto.dart';

import '../register_response/user.dart';

class LoginResponse {
  String? message;
  User? user;
  String? token;
  String? statusMessage;

  LoginResponse({this.message, this.user, this.token, this.statusMessage});

  factory LoginResponse.fromMap(Map<String, dynamic> data) => LoginResponse(
        message: data['message'] as String?,
        user: data['user'] == null
            ? null
            : User.fromMap(data['user'] as Map<String, dynamic>),
        token: data['token'] as String?,
        statusMessage: data['statusMsg'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'message': message,
        'user': user?.toMap(),
        'token': token,
        'statusMsg': statusMessage,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginResponse].
  factory LoginResponse.fromJson(String data) {
    return LoginResponse.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginResponse] to a JSON string.
  String toJson() => json.encode(toMap());

  AuthResponseDto toAuthResponseDto() {
    return AuthResponseDto(toUserDto(), message, statusMessage, token);
  }

  AuthUserDto toUserDto() {
    return AuthUserDto(user?.name, user?.email, user?.role);
  }
}
