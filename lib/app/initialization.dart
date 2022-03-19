import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_fire/app/utils/app_router.dart';
import 'package:todo_fire/auth/screens/login_screen.dart';
import 'package:todo_fire/todos/screens/todos_list.dart';

class AppInitializationScreen extends StatefulWidget {
  const AppInitializationScreen({Key? key}) : super(key: key);

  @override
  State<AppInitializationScreen> createState() =>
      _AppInitializationScreenState();
}

class _AppInitializationScreenState extends State<AppInitializationScreen> {
  @override
  void initState() {
    checkAuthState();
    super.initState();
  }

  checkAuthState() {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pushAndRemoveUntil(
            AppRouter.buildRoute(const LoginScreen()), (route) => false);
      });
    } else {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        Navigator.of(context).pushAndRemoveUntil(
            AppRouter.buildRoute(const TodosList()), (route) => false);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
