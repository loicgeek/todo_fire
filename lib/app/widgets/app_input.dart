import 'package:flutter/material.dart';
import 'package:todo_fire/app/utils/app_colors.dart';

class AppInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? placeholder;
  final bool obscureText;
  final TextInputType? textInputType;
  const AppInput({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.placeholder,
    this.obscureText = false,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Text(
              "$label",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: AppColors.primaryGrayText,
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: AppColors.primaryText,
            ),
            decoration: InputDecoration(
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              hintText: placeholder,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w300,
                color: AppColors.grayScale,
              ),
              fillColor: Color.fromRGBO(249, 249, 249, 0.5),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.primary),
                borderRadius: BorderRadius.circular(6),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.hexToColor("#DDDDDD")),
                borderRadius: BorderRadius.circular(6),
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.hexToColor("#DDDDDD")),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            validator: validator,
            obscureText: obscureText,
            keyboardType: textInputType,
          ),
        ],
      ),
    );
  }
}
