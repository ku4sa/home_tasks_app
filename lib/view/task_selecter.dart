import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/group_repository.dart';
import 'package:home_tasks_app/repositories/models/task/task.dart';
import 'package:home_tasks_app/repositories/room_repository.dart';
import 'package:home_tasks_app/repositories/task_repository.dart';
import 'package:home_tasks_app/theme/src/colors.dart';
import 'package:home_tasks_app/view/components/custom_app_bar.dart';
import 'package:home_tasks_app/view/components/task_view.dart';

class TaskSelecter extends StatelessWidget {
  const TaskSelecter({super.key});

  Future<List<Task>> _getTasks() async {
    List<Task> listTasks = [];
    final list = await GetIt.instance<GroupRepository>().getPublishGroupes();
    if (list == null) return [];
    for (var el in list) {
      var rooms = await GetIt.instance<RoomRepository>().getRoom(el.id!);
      if (rooms != null) {
        for (var room in rooms) {
          var tasks = await GetIt.instance<TaskRepository>().getTasks(room.id!);
          if (tasks != null) {
            listTasks.addAll(tasks);
          }
        }
      }
    }
    return listTasks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkWhite,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100),
        child: MyAppBar(
          canGoBack: true,
          title: 'Выбор задачи',
          onExit: () {
            Navigator.pop(context);
          },
          haveButtons: false,
        ),
      ),
      body: Center(
        child: FutureBuilder(
          future: _getTasks(),
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
                        final item = snapshot.data!.elementAt(index) as Task;
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(item);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: TaskView(
                              isImportSettings: true,
                              data: item,
                              haveSettings: false,
                            ),
                          ),
                        );
                      },
                    )
                  : const Text('Нечего импортировать');
            } else {
              return const Text('Нечего импортировать');
            }
          },
        ),
      ),
    );
  }
}
