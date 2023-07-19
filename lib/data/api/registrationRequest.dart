/// name : "Ahmed Abd Al-Muti"
/// email : "routeegyptnodejs101@gmail.com"
/// password : "Ahmed@123"
/// rePassword : "Ahmed@123"
/// phone : "01010700700"

class RegistrationRequest {
  String? name;
  String? email;
  String? password;
  String? rePassword;
  String? phone;
  RegistrationRequest({
    this.name,
    this.email,
    this.password,
    this.rePassword,
    this.phone,
  });

  RegistrationRequest.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    rePassword = json['rePassword'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['name'] = name;
    map['email'] = email;
    map['password'] = password;
    map['rePassword'] = rePassword;
    map['phone'] = phone;
    return map;
  }
}
