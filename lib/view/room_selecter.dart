import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/room/room.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/use_cases/group_use_case.dart';
import 'package:home_tasks_app/use_cases/room_use_case.dart';
import 'package:home_tasks_app/view/components/custom_app_bar.dart';
import 'package:home_tasks_app/view/components/groupes_and_rooms_view.dart';

class RoomSelecter extends StatelessWidget {
  const RoomSelecter({super.key});

  Future<List<Room>> _getRooms() async {
    List<Room> listRooms = [];
    final list = await GetIt.instance<GroupUseCase>().getPublishGroupes();
    if (list == null) return [];
    for (var el in list) {
      var rooms = await GetIt.instance<RoomUseCase>().getRoom(el.id!);
      if (rooms != null) {
        listRooms.addAll(rooms);
      }
    }
    return listRooms;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MyAppBar(
          canGoBack: true,
          title: 'Выбор комнаты',
          onExit: () {
            Navigator.pop(context);
          },
          haveButtons: false,
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getRooms(),
          initialData: const [],
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.hasData
                  ? ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final item = snapshot.data!.elementAt(index) as Room;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: GroupOfRoomsAndRoomsView(
                              isRoom: true,
                              data: item,
                              haveSettings: false,
                            ),
                          ),
                        );
                      },
                    )
                  : const Text('Нечего импортировать');
            } else {
              return Text('Нечего импортировать');
            }
          },
        ),
      ),
    );
  }
}
