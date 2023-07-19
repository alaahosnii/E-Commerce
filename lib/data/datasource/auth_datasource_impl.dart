import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/data/api/login_response/login_response.dart';
import 'package:ecommerce/domain/datasource/auth_datasource.dart';
import 'package:ecommerce/domain/model/auth_response_dto.dart';

class AuthDatasourceImpl implements AuthDataSource {
  ApiManager apiManager = ApiManager();

  AuthDatasourceImpl(this.apiManager);

  @override
  Future<AuthResponseDto> login(String email, String password) async {
    var response = await apiManager.login(email, password);

    return response.toAuthResponseDto();
  }

  @override
  Future<AuthResponseDto> register(
      {String? name,
      String? email,
      String? phone,
      String? password,
      String? rePassword}) async {
    var response = await apiManager.register(
        name: name,
        email: email,
        password: password,
        rePassword: rePassword,
        phone: phone);

    return response.toAuthResponseDto();
  }
}
