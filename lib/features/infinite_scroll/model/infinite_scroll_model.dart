// To parse this JSON data, do
//
//     final InfiniteScrollModel = InfiniteScrollModelFromJson(jsonString);

import 'dart:convert';

List<InfiniteScrollModel> infiniteScrollModelFromJson(String str) =>
    List<InfiniteScrollModel>.from(
        json.decode(str).map((x) => InfiniteScrollModel.fromJson(x)));

String infiniteScrollModelToJson(List<InfiniteScrollModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class InfiniteScrollModel {
  int userId;
  int id;
  String title;
  String body;

  InfiniteScrollModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory InfiniteScrollModel.fromJson(Map<String, dynamic> json) =>
      InfiniteScrollModel(
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
