import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_fire/app/utils/app_router.dart';
import 'package:todo_fire/auth/auth_service.dart';
import 'package:todo_fire/auth/screens/login_screen.dart';
import 'package:todo_fire/todos/models/todo_model.dart';
import 'package:todo_fire/todos/screens/add_todo.dart';
import 'package:todo_fire/todos/screens/todos_service.dart';

class TodosList extends StatefulWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  User user = FirebaseAuth.instance.currentUser!;

  late Stream<List<TodoModel>> todosStream;
  late TodosService _todosService;

  @override
  void initState() {
    _todosService = TodosService();
    todosStream = _todosService.findTodos(user.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(AppRouter.buildRoute(AddTodo()));
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: Text('To-do Fire'),
        actions: [
          IconButton(
            onPressed: () async {
              await AuthService().logout();
              Navigator.of(context).pushAndRemoveUntil(
                  AppRouter.buildRoute(const LoginScreen()), (route) => false);
            },
            icon: Icon(
              Icons.exit_to_app,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Welcome back, ${user.email} ",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder<List<TodoModel>>(
            stream: todosStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<TodoModel>> snapshot) {
              log(snapshot.connectionState.toString());
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } else if (snapshot.hasData) {
                List<TodoModel> todos = snapshot.data!;
                return Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      var todo = todos[index];
                      return CheckboxListTile(
                        value: todo.done,
                        onChanged: (value) {
                          _todosService.updateTodo(id: todo.id!, done: value);
                        },
                        title: Text(todo.title),
                        subtitle: todo.dueDate != null
                            ? Text(
                                DateFormat('EEE, M/d/y').format(todo.dueDate!))
                            : null,
                      );
                    },
                    itemCount: todos.length,
                  ),
                );
              }

              return Container(
                child: Text("none"),
              );
            },
          ),
        ],
      ),
    );
  }
}
