// To parse this JSON data, do
//
//     final notaModel = notaModelFromJson(jsonString);

import 'dart:convert';

List<NotaModel> notaModelFromJson(String str) =>
    List<NotaModel>.from(json.decode(str).map((x) => NotaModel.fromJson(x)));

String notaModelToJson(List<NotaModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotaModel {
  int userId;
  int id;
  String title;
  String body;

  NotaModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory NotaModel.fromJson(Map<String, dynamic> json) => NotaModel(
        userId: json["userId"] == null ? null : json["userId"],
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        body: json["body"] == null ? null : json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId == null ? null : userId,
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "body": body == null ? null : body,
      };
}
