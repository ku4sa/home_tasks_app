import "package:flutter/material.dart";
import "package:home_tasks_app/repositories/models/data_model.dart";
import "package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart";
import "package:home_tasks_app/repositories/models/room/room.dart";

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

  final void Function()? onTapSettings;
  final bool isRoom;
  final DataModel data;

  @override
  Widget build(BuildContext context) {
    final name = (data is GroupOfRooms)
        ? (data as GroupOfRooms).name
        : (data as Room).name;
    final count = (data is GroupOfRooms)
        ? (data as GroupOfRooms).rooms.length
        : (data as Room).tasks.length;
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                name,
                style: AppTextStyles.bigText,
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                "${isRoom ? 'Задач' : 'Комнат'} : $count",
                style: AppTextStyles.smallText,
              ),
            ),
            if (haveSettings)
              IconButton(
                onPressed: onTapSettings,
                icon: const Icon(Icons.settings),
              )
          ],
        ),
      ),
    );
  }
}
