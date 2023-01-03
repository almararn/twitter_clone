import 'dart:convert';

List<Users> usersFromJson(String str) =>
    List<Users>.from(json.decode(str).map((x) => Users.fromJson(x)));

String usersToJson(List<Users> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Users {
  Users({
    this.userId,
    this.firstName,
    this.lastName,
    this.handle,
  });

  int? userId;
  String? firstName;
  String? lastName;
  String? handle;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        userId: json["userId"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        handle: json["handle"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "firstName": firstName,
        "lastName": lastName,
        "handle": handle,
      };
}
