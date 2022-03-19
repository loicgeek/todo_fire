import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_fire/app/utils/app_router.dart';
import 'package:todo_fire/auth/auth_service.dart';
import 'package:todo_fire/auth/screens/login_screen.dart';

class TodosList extends StatefulWidget {
  const TodosList({Key? key}) : super(key: key);

  @override
  State<TodosList> createState() => _TodosListState();
}

class _TodosListState extends State<TodosList> {
  User user = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ],
      ),
    );
  }
}
