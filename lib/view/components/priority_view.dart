import 'package:flutter/material.dart';
import 'package:home_tasks_app/theme/theme.dart';

class PriorityView extends StatefulWidget {
  final int? priority;
  final void Function(int) onChanged;

  const PriorityView({
    super.key,
    this.priority,
    required this.onChanged,
  });

  @override
  State<PriorityView> createState() => _PriorityViewState();
}

class _PriorityViewState extends State<PriorityView> {
  late Color priorityColor;
  late int priority;
  @override
  void initState() {
    priority = widget.priority ?? 0;
    priorityColor = getPriorityColor();
    super.initState();
  }

  Color getPriorityColor() {
    switch (priority) {
      case 1:
        return AppColors.green;
      case 2:
        return AppColors.yellow;
      case 3:
        return AppColors.red;
      default:
        return AppColors.disabled;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            'Приоритет:',
            style: AppTextStyles.bigText,
            textAlign: TextAlign.right,
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              _priorityIcon(1),
              _priorityIcon(2),
              _priorityIcon(3),
            ],
          ),
        ),
      ],
    );
  }

  Widget _priorityIcon(int code) {
    return GestureDetector(
      onTap: () {
        setState(() {
          priority = code;
          priorityColor = getPriorityColor();
          widget.onChanged(priority);
        });
      },
      child: code <= priority
          ? Icon(
              code <= priority ? Icons.flag : Icons.flag_outlined,
              color: priorityColor,
              size: 40,
            )
          : Icon(
              Icons.flag_outlined,
              color: AppColors.disabled,
              size: 40,
            ),
    );
  }
}
