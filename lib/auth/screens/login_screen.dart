import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:todo_fire/app/loaders/app_loader.dart';
import 'package:todo_fire/app/utils/app_colors.dart';
import 'package:todo_fire/app/utils/app_router.dart';
import 'package:todo_fire/app/widgets/app_back_button.dart';
import 'package:todo_fire/app/widgets/app_button.dart';
import 'package:todo_fire/app/widgets/app_input.dart';
import 'package:todo_fire/auth/auth_service.dart';
import 'package:todo_fire/auth/screens/register_screen.dart';
import 'package:todo_fire/todos/screens/todos_list.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late AuthService _authService;
  String? error;
  final LoaderController _loaderController = AppLoader.bounce();

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _authService = AuthService();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
        title: Text("Login"),
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

                SizedBox(
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

                SizedBox(
                  height: 45,
                ),
                if (error != null) ...[
                  Text(
                    error!,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                ],

                AppButton(
                  text: "Login",
                  onTap: () async {
                    setState(() {
                      error = null;
                    });
                    //if (_formKey.currentState!.validate()) {
                    try {
                      _loaderController.open(context);
                      await _authService.loginWithEmailAndPassword(
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
                    //}
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: RichText(
                    text: TextSpan(
                      text: "Dont have an account? ",
                      style: TextStyle(
                        color: AppColors.primaryGrayText,
                      ),
                      children: [
                        TextSpan(
                          text: "Create ",
                          style: TextStyle(
                            color: AppColors.primary,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context)
                                  .push(AppRouter.buildRoute(RegisterScreen()));
                            },
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
