class TodoModel {
  String? id;
  late String title;
  late bool done;
  late String userId;
  String? imageUrl;
  DateTime? dueDate;
  TodoModel({
    this.id,
    required this.title,
    this.done = false,
    this.dueDate,
    this.imageUrl,
    required this.userId,
  });
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      id: json['id'],
      done: json["done"],
      userId: json["userId"],
      imageUrl: json["imageUrl"],
      dueDate: json["dueDate"] != null ? DateTime.parse(json["dueDate"]) : null,
    );
  }
  TodoModel copyWith({String? id}) {
    return TodoModel(
      title: title,
      id: id ?? this.id,
      done: done,
      dueDate: dueDate,
      imageUrl: imageUrl,
      userId: userId,
    );
  }

  toJson() {
    return {
      "id": id,
      "title": title,
      "done": done,
      "userId": userId,
      "imageUrl": imageUrl,
      "dueDate": dueDate != null ? dueDate!.toIso8601String() : null,
    };
  }
}
