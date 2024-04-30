import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:home_tasks_app/theme/src/textstyle.dart';

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    this.onTap,
    required this.label,
  });
  final String label;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: AppTextStyles.bigText,
            ),
            IconButton(
              onPressed: onTap,
              icon: SvgPicture.asset('assets/icons/clear.svg'),
            )
          ],
        ),
      ),
    );
  }
}
