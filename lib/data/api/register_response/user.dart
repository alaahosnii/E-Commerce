import 'dart:convert';

class User {
  String? name;
  String? email;
  String? role;

  User({this.name, this.email, this.role});

  factory User.fromMap(Map<String, dynamic> data) => User(
        name: data['name'] as String?,
        email: data['email'] as String?,
        role: data['role'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'name': name,
        'email': email,
        'role': role,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [User].
  factory User.fromJson(String data) {
    return User.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [User] to a JSON string.
  String toJson() => json.encode(toMap());
}
