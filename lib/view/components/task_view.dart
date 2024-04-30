import "package:flutter/material.dart";
import "package:get_it/get_it.dart";

import "package:home_tasks_app/repositories/models/task/task.dart";
import "package:home_tasks_app/use_cases/group_use_case.dart";
import "package:home_tasks_app/view/components/components.dart";

import "../../repositories/models/user/user.dart";
import "../../theme/src/colors.dart";
import "../../theme/src/textstyle.dart";

class TaskView extends StatelessWidget {
  const TaskView({
    super.key,
    required this.data,
    this.onTapSettings,
    this.haveSettings = true,
  });
  final bool haveSettings;
  final void Function(bool fullEditting)? onTapSettings;
  final Task data;

  @override
  Widget build(BuildContext context) {
    final color = data.status == 2
        ? AppColors.yellow
        : data.status == 1
            ? AppColors.green
            : AppColors.red;
    final users = GetIt.instance<GroupUseCase>().getUsers();
    return Container(
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(
          color: color,
        ),
        borderRadius: BorderRadius.circular(5),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      overflow: TextOverflow.fade,
                      data.name,
                      style: AppTextStyles.bigText,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                        height: 30,
                        child: users != null
                            ? MyDropDownButton(
                                content: users,
                                selectedValue: data.user != null
                                    ? User(username: data.user!)
                                    : null,
                                onChanged: (p0) {})
                            : const SizedBox()),
                  ),
                  Align(
                    alignment: users != null
                        ? Alignment.bottomRight
                        : Alignment.centerRight,
                    child: Text(
                      "${data.getStatus()?.getName()}",
                      maxLines: 1,
                      overflow: TextOverflow.clip,
                      style: AppTextStyles.smallText.copyWith(
                        color: color,
                      ),
                    ),
                  ),

                  //исполнитель и статус
                ],
              ),
            ),
            if (haveSettings)
              IconButton(
                onPressed: () {
                  onTapSettings!(true);
                },
                icon: const Icon(Icons.settings),
              ),
          ],
        ),
      ),
    );
  }
}
