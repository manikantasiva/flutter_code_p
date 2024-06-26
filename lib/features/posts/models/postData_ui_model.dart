import 'dart:convert';

List<PostDataUiModel> postDataUiModelFromJson(String str) =>
    List<PostDataUiModel>.from(json.decode(str).map((x) => PostDataUiModel.fromJson(x)));

String postDataUiModelToJson(List<PostDataUiModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PostDataUiModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  PostDataUiModel({
    this.userId,
    this.id,
    this.title,
    this.body,
  });

  factory PostDataUiModel.fromJson(Map<String, dynamic> json) {
    return PostDataUiModel(
      userId: json["userId"] ?? 0,
      id: json["id"] ?? 0,
      title: json["title"] ?? '',
      body: json["body"] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId ?? 0,
        "id": id ?? 0,
        "title": title ?? '',
        "body": body ?? '',
      };
}
