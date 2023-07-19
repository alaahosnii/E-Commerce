import 'package:ecommerce/data/api/register_response/user.dart';
import 'package:ecommerce/domain/model/auth_user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserProvider extends Cubit<CurrentUserState> {
  UserProvider() : super(LoggedOutState());

  void login(LoggedInState loggedInState) {
    emit(loggedInState);
  }

  void logout(LoggedOutState loggedOutState) {
    emit(loggedOutState);
  }
}

abstract class CurrentUserState {}

class LoggedInState extends CurrentUserState {
  AuthUserDto user;
  String token;

  LoggedInState({required this.user, required this.token});
}

class LoggedOutState extends CurrentUserState {}
