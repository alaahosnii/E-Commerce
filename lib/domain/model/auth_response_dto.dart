import 'package:ecommerce/domain/model/auth_user_dto.dart';

class AuthResponseDto {
  AuthUserDto userDto;
  String? message;
  String? statusMsg;
  String? token;

  AuthResponseDto(this.userDto, this.message, this.statusMsg, this.token);
}
