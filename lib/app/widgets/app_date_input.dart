import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_fire/app/utils/app_colors.dart';

class AppDateInput extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final String label;
  final String? placeholder;

  const AppDateInput({
    Key? key,
    required this.controller,
    this.validator,
    required this.label,
    this.placeholder,
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
              DateTimeField(
                format: DateFormat('dd/MM/y'),
                controller: controller,
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
                    borderSide:
                        BorderSide(color: AppColors.hexToColor("#DDDDDD")),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  border: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: AppColors.hexToColor("#DDDDDD")),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                onShowPicker: (context, currentValue) {
                  return showDatePicker(
                    context: context,
                    firstDate: DateTime(1900),
                    initialDate: currentValue ?? DateTime.now(),
                    lastDate: DateTime(2100),
                  );
                },
              )
            ]));
  }
}
