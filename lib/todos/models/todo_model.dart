class TodoModel {
  String? id;
  late String title;
  late bool done;
  late String userId;
  DateTime? dueDate;
  TodoModel({
    this.id,
    required this.title,
    this.done = false,
    this.dueDate,
    required this.userId,
  });
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      title: json['title'],
      id: json['id'],
      done: json["done"],
      userId: json["userId"],
      dueDate: json["dueDate"] != null ? DateTime.parse(json["dueDate"]) : null,
    );
  }
  TodoModel copyWith({String? id}) {
    return TodoModel(
      title: title,
      id: id ?? this.id,
      done: done,
      dueDate: dueDate,
      userId: userId,
    );
  }

  toJson() {
    return {
      "id": id,
      "title": title,
      "done": done,
      "userId": userId,
      "dueDate": dueDate != null ? dueDate!.toIso8601String() : null,
    };
  }
}
