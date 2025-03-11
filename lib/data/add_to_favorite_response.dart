import 'dart:convert';

class AddToFavoriteResponse {
  String? status;
  String? message;
  List<String>? data;

  AddToFavoriteResponse({this.status, this.message, this.data});

  factory AddToFavoriteResponse.fromMap(Map<String, dynamic> data) {
    return AddToFavoriteResponse(
      status: data['status'] as String?,
      message: data['message'] as String?,
      data: (data['data'] as List<dynamic>?)
          ?.map((element) => element.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toMap() => {
        'status': status,
        'message': message,
        'data': data,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [AddToFavoriteResponse].
  factory AddToFavoriteResponse.fromJson(String data) {
    return AddToFavoriteResponse.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [AddToFavoriteResponse] to a JSON string.
  String toJson() => json.encode(toMap());
}
