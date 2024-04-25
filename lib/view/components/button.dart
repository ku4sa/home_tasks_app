import 'package:flutter/material.dart';
import 'package:home_tasks_app/theme/src/colors.dart';

class MyFloatingActionButton extends StatelessWidget {
  final void Function()? onPressed;

  const MyFloatingActionButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      hoverColor: AppColors.white.withOpacity(0.2),
      focusColor: AppColors.white.withOpacity(0.2),
      shape: const CircleBorder(eccentricity: 1),
      onPressed: onPressed,
      backgroundColor: AppColors.darkBlue,
      child: Icon(
        Icons.add,
        color: AppColors.white,
      ),
    );
  }
}
