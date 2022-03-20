import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_fire/todos/models/todo_model.dart';

class TodosService {
  CollectionReference<TodoModel> todos = FirebaseFirestore.instance
      .collection('todos')
      .withConverter<TodoModel>(
        fromFirestore: (snapshot, _) => TodoModel.fromJson(snapshot.data()!),
        toFirestore: (movie, _) => movie.toJson(),
      );

  Stream<List<TodoModel>> findTodos(String userId) {
    var stream = todos.where("userId", isEqualTo: userId).snapshots();
    return stream.map(
      (qShot) => qShot.docs
          .map(
            (doc) => doc.data().copyWith(id: doc.id),
          )
          .toList(),
    );
  }

  addTodo({
    required String title,
    DateTime? dueDate,
    required String userId,
  }) async {
    TodoModel todo = TodoModel(
      title: title,
      dueDate: dueDate,
      userId: userId,
    );
    return await todos.add(todo);
  }

  updateTodo({required String id, bool? done}) async {
    DocumentReference todo = FirebaseFirestore.instance.doc('todos/$id');
    await todo.update({
      "done": done,
    });
  }
}
