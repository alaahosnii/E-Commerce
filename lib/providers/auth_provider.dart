import 'package:ecommerce/data/api/register_response/user.dart';
import 'package:ecommerce/domain/model/auth_user_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends Cubit<CurrentUserState> {
  UserProvider() : super(LoggedOutState()) {
    getIfUserLoggedIn();
  }

  void login(LoggedInState loggedInState) async {
    print("logging");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", loggedInState.token);
    sharedPreferences.setString("name", loggedInState.user.name!);
    sharedPreferences.setString("email", loggedInState.user.email!);
    sharedPreferences.setString("role", loggedInState.user.role!);
    emit(loggedInState);
  }

  void logout(LoggedOutState loggedOutState) {
    emit(loggedOutState);
  }

  void getIfUserLoggedIn() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var token = sharedPreferences.getString("token");
    var name = sharedPreferences.getString("name");
    var email = sharedPreferences.getString("email");
    var role = sharedPreferences.getString("role");
    print("token: $token");
    if (token != null) {
      emit(LoggedInState(
        user: AuthUserDto(
          name,
          email,
          role,
        ),
        token: token,
      ));
    } else {
      emit(LoggedOutState());
    }
  }
}

abstract class CurrentUserState {}

class LoggedInState extends CurrentUserState {
  AuthUserDto user;
  String token;

  LoggedInState({required this.user, required this.token});
}

class LoggedOutState extends CurrentUserState {}
