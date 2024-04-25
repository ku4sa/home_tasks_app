import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/use_cases/group_use_case.dart';
import 'package:home_tasks_app/view/components/custom_app_bar.dart';
import 'package:home_tasks_app/view/components/groupes_and_rooms_view.dart';

class GroupSelecter extends StatelessWidget {
  const GroupSelecter({super.key});

  Future<List<GroupOfRooms>> _getGroupes() async {
    final list = await GetIt.instance<GroupUseCase>().getPublishGroupes();
    return list ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MyAppBar(
          canGoBack: true,
          title: 'Выбор помещения',
          onExit: () {
            context.pop();
          },
          haveButtons: false,
        ),
      ),
      body: FutureBuilder(
        future: _getGroupes(),
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
                      final item =
                          snapshot.data!.elementAt(index) as GroupOfRooms;
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop(item);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: GroupOfRoomsAndRoomsView(
                            isRoom: false,
                            data: item,
                            haveSettings: false,
                          ),
                        ),
                      );
                    },
                  )
                : const Text('Нечего импортировать');
          }
          else{
            return Text('Нечего импортировать');
          }
        },
      ),
    );
  }
}
