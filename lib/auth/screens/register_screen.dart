import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_fire/app/loaders/app_loader.dart';
import 'package:todo_fire/app/utils/app_colors.dart';
import 'package:todo_fire/app/utils/app_router.dart';
import 'package:todo_fire/app/utils/validators.dart';
import 'package:todo_fire/app/widgets/app_back_button.dart';
import 'package:todo_fire/app/widgets/app_button.dart';
import 'package:todo_fire/app/widgets/app_input.dart';
import 'package:todo_fire/auth/auth_service.dart';
import 'package:todo_fire/auth/screens/login_screen.dart';
import 'package:todo_fire/todos/screens/todos_list.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AuthService _authService;
  String? error;
  final LoaderController _loaderController = AppLoader.bounce();

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authService = AuthService();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text("Create Account"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
            child: Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.symmetric(
                //     vertical: 20.0,
                //     horizontal: 10,
                //   ),
                //   child: Image.asset("assets/images/bongalo.png"),
                // ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 10,
                  ),
                  child: Text("Let’s get to know you better"),
                ),
                const SizedBox(
                  height: 20,
                ),
                AppInput(
                  controller: _emailController,
                  label: "Email",
                  placeholder: "Enter email address",
                ),
                AppInput(
                  controller: _passwordController,
                  label: "Password",
                  placeholder: "Choose a password",
                  obscureText: true,
                ),

                const SizedBox(
                  height: 45,
                ),

                AppButton(
                  text: "Create Account",
                  onTap: () async {
                    //if (_formKey.currentState!.validate()) {
                    try {
                      _loaderController.open(context);
                      await _authService.registerWithEmailAndPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      _loaderController.close();
                      Navigator.of(context).pushAndRemoveUntil(
                          AppRouter.buildRoute(const TodosList()),
                          (route) => false);
                    } catch (e) {
                      print(e);
                      if (e is FirebaseAuthException) {
                        error = e.message;
                      } else {
                        error = e.toString();
                      }
                      setState(() {});
                      _loaderController.close();
                    }
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: RichText(
                    text: const TextSpan(
                      text: "Already have an account? ",
                      style: TextStyle(
                        color: AppColors.primaryGrayText,
                      ),
                      children: [
                        TextSpan(
                          text: "Login ",
                          style: TextStyle(
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
