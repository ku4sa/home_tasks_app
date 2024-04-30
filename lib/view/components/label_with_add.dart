import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

class LabelWithAdd extends StatelessWidget {
  final String label;
  final void Function()? onAdd;

  const LabelWithAdd({
    super.key,
    required this.label,
    this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: ShapeDecoration(
        color: AppColors.lightBlue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.nameForGroup,
            ),
          ),
          if (onAdd != null)
            IconButton(
              onPressed: onAdd,
              icon: SvgPicture.asset('assets/icons/add_round.svg'),
            ),
        ],
      ),
    );
  }
}
