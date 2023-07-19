import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/domain/model/auth_response_dto.dart';

import '../../data/api/login_response/login_response.dart';

abstract class AuthDataSource {
  Future<AuthResponseDto> login(String email, String password);
  Future<AuthResponseDto> register(
      {String? name,
      String? email,
      String? phone,
      String? password,
      String? rePassword});
}
