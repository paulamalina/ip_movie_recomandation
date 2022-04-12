// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
  Model({
    this.id=0,
    this.email='',
    this.name='',
    this.password='',
    this.role='',
    this.gender='',
    this.birthdate='',
    this.country='',
    this.phoneNumber='',
    this.age=0,
  });

  int id;
  String email;
  String name;
  String password;
  String role;
  String gender;
  String birthdate;
  String country;
  String phoneNumber;
  int age;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["id"],
    email: json["email"],
    name: json["name"],
    password: json["password"],
    role: json["role"],
    gender: json["gender"],
    birthdate: json["country"],
    phoneNumber: json["phoneNumber"],
    age: json["age"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "email": email,
    "name": name,
    "password": password,
    "role": role,
    "gender": gender,
    "birthdate": birthdate,
    "country": country,
    "phoneNumber": phoneNumber,
    "age": age,
  };
}
