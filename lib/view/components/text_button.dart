import 'package:flutter/material.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

class MyTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;

  const MyTextButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        padding: const MaterialStatePropertyAll(EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 10,
        )),
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(MaterialState.pressed)) {
              return AppColors.green.withOpacity(0.5);
            } else if (states.contains(MaterialState.disabled)) {
              return AppColors.disabled;
            } else if (states.contains(MaterialState.hovered)) {
              return AppColors.green.withOpacity(0.5);
            } else {
              return AppColors.green;
            }
          },
        ),
        shape: MaterialStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: AppTextStyles.headerStyle,
        ),
      ),
    );
  }
}
