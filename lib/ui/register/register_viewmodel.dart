import 'package:ecommerce/data/api/api_manager.dart';
import 'package:ecommerce/data/api/register_response/register_response.dart';
import 'package:ecommerce/data/datasource/auth_datasource_impl.dart';
import 'package:ecommerce/data/repository/auth_repository_impl.dart';
import 'package:ecommerce/domain/datasource/auth_datasource.dart';
import 'package:ecommerce/domain/model/auth_response_dto.dart';
import 'package:ecommerce/domain/repository/auth_repository.dart';
import 'package:ecommerce/domain/usecases/register_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterViewModel extends Cubit<RegisterViewState> {
  late ApiManager apiManager;
  late AuthDataSource authDataSource;
  late AuthRepository authRepository;
  late RegisterUseCase registerUseCase;

  RegisterViewModel() : super(InitialState()) {
    apiManager = ApiManager();
    authDataSource = AuthDatasourceImpl(apiManager);
    authRepository = AuthRepositoryImpl(authDataSource);
    registerUseCase = RegisterUseCase(authRepository);
  }

  void register(String name, String email, String password, String rePassword,
      String phone) async {
    emit(LoadingState(loadingMessage: 'Loading...'));
    var response =
        await registerUseCase.invoke(name, email, password, rePassword, phone);

    if (response.statusMsg == 'fail') {
      emit(FailState(failMessage: response.message));
      return;
    }
    emit(SuccessState(authResponseDto: response));
  }
}

abstract class RegisterViewState {}

class InitialState extends RegisterViewState {}

class LoadingState extends RegisterViewState {
  String? loadingMessage;

  LoadingState({this.loadingMessage});
}

class SuccessState extends RegisterViewState {
  AuthResponseDto? authResponseDto;

  SuccessState({this.authResponseDto});
}

class FailState extends RegisterViewState {
  String? failMessage;

  FailState({this.failMessage});
}
