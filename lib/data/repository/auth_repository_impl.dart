import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/data/api/login_response/login_response.dart';
import 'package:ecommerce/domain/datasource/auth_datasource.dart';
import 'package:ecommerce/domain/model/auth_response_dto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthDataSource authDataSource;
  AuthRepositoryImpl(this.authDataSource);

  @override
  Future<AuthResponseDto> login(String email, String password) {
    return authDataSource.login(email, password);
  }

  @override
  Future<AuthResponseDto> register(
      {String? name,
      String? email,
      String? phone,
      String? password,
      String? rePassword}) {
    return authDataSource.register(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone);
  }
}
