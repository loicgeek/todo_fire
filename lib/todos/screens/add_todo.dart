import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:todo_fire/app/loaders/app_loader.dart';
import 'package:todo_fire/app/utils/firebase_utils.dart';
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
  File? _localImage;

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
          GestureDetector(
            onTap: () async {
              final ImagePicker _picker = ImagePicker();
              // Pick an image
              final XFile? image =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                _localImage = File(image.path);
                setState(() {});
              }
            },
            child: Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: _localImage != null
                    ? DecorationImage(
                        image: FileImage(_localImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
                borderRadius: BorderRadius.circular(10),
                color: Colors.black.withOpacity(.5),
              ),
              child: Icon(
                Icons.add_a_photo,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          AppButton(
            text: "Add",
            onTap: () async {
              try {
                _loader.open(context);
                String? imageUrl;
                if (_localImage != null) {
                  imageUrl = await uploadImageToFirebase(_localImage!);
                }
                await _todosService.addTodo(
                  title: _titleController.text,
                  userId: user.uid,
                  imageUrl: imageUrl,
                  dueDate: DateFormat('dd/MM/y').parse(_dateController.text),
                );
                _titleController.clear();
                _dateController.clear();
                _localImage = null;
                setState(() {});
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
