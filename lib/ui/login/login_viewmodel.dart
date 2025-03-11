import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/api/login_response/login_response.dart';
import 'package:ecommerce/domain/customException/custom_exception.dart';
import 'package:ecommerce/domain/model/auth_response_dto.dart';
import 'package:ecommerce/domain/usecases/login_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/register_response/register_response.dart';
import '../../data/datasource/auth_datasource_impl.dart';
import '../../data/repository/auth_repository_impl.dart';
import '../../domain/datasource/auth_datasource.dart';
import '../../domain/repository/auth_repository.dart';
import '../register/register_viewmodel.dart';

class LoginViewModel extends Cubit<LoginViewState> {
  late ApiManager apiManager;
  late AuthDataSource authDataSource;
  late AuthRepository authRepository;
  late LoginUseCase loginUseCase;

  LoginViewModel() : super(LoginInitialState()) {
    apiManager = ApiManager();
    authDataSource = AuthDatasourceImpl(apiManager);
    authRepository = AuthRepositoryImpl(authDataSource);
    loginUseCase = LoginUseCase(authRepository);
  }
  void login(String email, String password) async {
    emit(LoginLoadingState(loadingMessage: 'Loading...'));
    try {
      var response = await loginUseCase.invoke(email, password);
      emit(LoginSuccessState(response));
    } on ServerError catch (e) {
      emit(LoginFailState(failMessage: 'Fail', failContent: e.errorMessage));
    }
  }
}

abstract class LoginViewState {}

class LoginInitialState extends LoginViewState {}

class LoginLoadingState extends LoginViewState {
  String? loadingMessage;

  LoginLoadingState({this.loadingMessage});
}

class LoginSuccessState extends LoginViewState {
  AuthResponseDto loginResponse;

  LoginSuccessState(this.loginResponse);
}

class LoginFailState extends LoginViewState {
  String? failMessage;
  String? failContent;

  LoginFailState({this.failMessage, this.failContent});
}
