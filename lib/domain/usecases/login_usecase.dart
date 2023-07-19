import 'package:ecommerce/data/api/login_response/login_response.dart';
import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';

import '../model/auth_response_dto.dart';

class LoginUseCase {
  AuthRepository authRepository;

  LoginUseCase(this.authRepository);

  Future<AuthResponseDto> invoke(String email, String password) async {
    return authRepository.login(email, password);
  }
}
