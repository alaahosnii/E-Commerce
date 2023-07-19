import 'package:ecommerce/data/api/login_response/login_response.dart';

import '../../data/api/register_response/register_response.dart';
import '../model/auth_response_dto.dart';

abstract class AuthRepository {
  Future<AuthResponseDto> login(String email, String password);
  Future<AuthResponseDto> register(
      {String name,
      String email,
      String phone,
      String password,
      String rePassword});
}
