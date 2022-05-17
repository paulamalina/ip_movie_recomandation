// To parse this JSON data, do
//
//     final model = modelFromJson(jsonString);

import 'dart:convert';

Model modelFromJson(String str) => Model.fromJson(json.decode(str));

String modelToJson(Model data) => json.encode(data.toJson());

class Model {
  Model({
    required this.timestamp,
    required this.status,
    required this.error,
    required this.message,
    required this.path,
  });

  DateTime timestamp;
  int status;
  String error;
  String message;
  String path;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    timestamp: DateTime.parse(json["timestamp"]),
    status: json["status"],
    error: json["error"],
    message: json["message"],
    path: json["path"],
  );

  Map<String, dynamic> toJson() => {
    "timestamp": timestamp.toIso8601String(),
    "status": status,
    "error": error,
    "message": message,
    "path": path,
  };
}
