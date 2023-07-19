import 'dart:convert';

import '../../../domain/model/auth_response_dto.dart';
import '../../../domain/model/auth_user_dto.dart';
import 'user.dart';

class LoginRegisterResponse {
  String? message;
  String? statusMsg;
  String? token;
  User? user;
  LoginRegisterResponse({this.message, this.user, this.token, this.statusMsg});

  factory LoginRegisterResponse.fromMap(Map<String, dynamic> data) {
    return LoginRegisterResponse(
      message: data['message'] as String?,
      statusMsg: data['statusMsg'] as String?,
      user: data['user'] == null
          ? null
          : User.fromMap(data['user'] as Map<String, dynamic>),
      token: data['token'] as String?,
    );
  }

  Map<String, dynamic> toMap() => {
        'message': message,
        'statusMsg': statusMsg,
        'user': user?.toMap(),
        'token': token,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LoginRegisterResponse].
  factory LoginRegisterResponse.fromJson(String data) {
    return LoginRegisterResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  AuthResponseDto toAuthResponseDto() {
    return AuthResponseDto(toUserDto(), message, statusMsg, token);
  }

  AuthUserDto toUserDto() {
    return AuthUserDto(user?.name, user?.email, user?.role);
  }

  /// `dart:convert`
  ///
  /// Converts [LoginRegisterResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
