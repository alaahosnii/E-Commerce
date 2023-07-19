import 'package:ecommerce/data/api/login_response/login_response.dart';
import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';

import '../model/auth_response_dto.dart';

class RegisterUseCase {
  AuthRepository authRepository;

  RegisterUseCase(this.authRepository);

  Future<AuthResponseDto> invoke(String name, String email, String password,
      String rePassword, String phone) async {
    return authRepository.register(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone);
  }
}
