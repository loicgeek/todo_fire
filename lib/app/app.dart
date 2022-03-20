import 'package:flutter/material.dart';
import 'package:todo_fire/app/initialization.dart';
import 'package:todo_fire/app/utils/app_colors.dart';
import 'package:todo_fire/auth/screens/login_screen.dart';
import 'package:todo_fire/todos/screens/todos_list.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AppInitializationScreen(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        primarySwatch: AppColors.createMaterialColor(Colors.deepPurple),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.deepPurple,
        ),
      ),
    );
  }
}
