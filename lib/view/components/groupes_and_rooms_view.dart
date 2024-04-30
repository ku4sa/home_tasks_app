import "package:flutter/material.dart";
import "package:get_it/get_it.dart";
import "package:home_tasks_app/repositories/auth_repository.dart";
import "package:home_tasks_app/repositories/models/data_model.dart";
import "package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart";

import "../../theme/src/colors.dart";
import "../../theme/src/textstyle.dart";

class GroupOfRoomsAndRoomsView extends StatelessWidget {
  const GroupOfRoomsAndRoomsView({
    super.key,
    required this.data,
    this.isRoom = true,
    this.onTapSettings,
    this.haveSettings = true,
  });
  final bool haveSettings;

  final void Function(bool fullEditting)? onTapSettings;
  final bool isRoom;
  final DataModel data;

  @override
  Widget build(BuildContext context) {
    final isPublicGroup = (data is GroupOfRooms)
        ? ((data as GroupOfRooms).author !=
                GetIt.instance<AuthorizationRepository>()
                    .activeUser
                    .value
                    ?.username
            ? true
            : false)
        : null;
    final name = data.getName();
    final count = data.getCount();

    return Container(
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: AppColors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            (isPublicGroup != null && isPublicGroup == true)
                ? Expanded(
                    child: Center(
                      child: Icon(
                        Icons.public,
                        color: AppColors.disabled,
                      ),
                    ),
                  )
                : const SizedBox(
                    width: 20,
                  ),
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: AppTextStyles.bigText,
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                "${isRoom ? 'Задач' : 'Комнат'} : $count",
                style: AppTextStyles.smallText,
              ),
            ),
            if (haveSettings)
              IconButton(
                onPressed: () {
                  onTapSettings!(isPublicGroup != null ? !isPublicGroup : true);
                },
                icon: const Icon(Icons.settings),
              )
          ],
        ),
      ),
    );
  }
}
