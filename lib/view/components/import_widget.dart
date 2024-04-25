import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

class ImportButton extends StatelessWidget {
  final void Function() onTap;
  const ImportButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text(
          'Импорт настроек:',
          style: AppTextStyles.bigText,
        ),
        const SizedBox(
          width: 10,
        ),
        IconButton(
          style: IconButton.styleFrom(
            backgroundColor: AppColors.lightBlue,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          ),
          onPressed: onTap,
          icon: SvgPicture.asset('assets/icons/import.svg'),
        )
      ],
    );
  }
}
