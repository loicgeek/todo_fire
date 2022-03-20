import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_fire/app/loaders/app_loader.dart';
import 'package:todo_fire/app/widgets/app_button.dart';
import 'package:todo_fire/app/widgets/app_date_input.dart';
import 'package:todo_fire/app/widgets/app_input.dart';
import 'package:todo_fire/todos/screens/todos_service.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  late TextEditingController _titleController;
  late TextEditingController _dateController;
  DateTime? _dueDate;

  late TodosService _todosService;
  User user = FirebaseAuth.instance.currentUser!;
  LoaderController _loader = AppLoader.bounce();

  @override
  void initState() {
    _titleController = TextEditingController();
    _dateController = TextEditingController();
    _todosService = TodosService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Todo'),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          AppInput(
            controller: _titleController,
            label: "Title",
          ),
          SizedBox(
            height: 20,
          ),
          AppDateInput(controller: _dateController, label: "Date"),
          SizedBox(
            height: 40,
          ),
          AppButton(
            text: "Add",
            onTap: () async {
              try {
                _loader.open(context);
                await _todosService.addTodo(
                  title: _titleController.text,
                  userId: user.uid,
                  dueDate: DateFormat('dd/MM/y').parse(_dateController.text),
                );
                _titleController.clear();
                _dateController.clear();
                _loader.close();
              } catch (e) {
                _loader.close();
                log(e.toString());
              }
            },
          )
        ],
      ),
    );
  }
}
