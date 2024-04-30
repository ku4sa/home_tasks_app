import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/repositories/models/task/task.dart';
import 'package:home_tasks_app/theme/theme.dart';
import 'package:home_tasks_app/view/components/task_view.dart';
import 'package:home_tasks_app/view/tasks_page/tasks_page_bloc.dart';
import 'package:home_tasks_app/view/tasks_page/tasks_page_events.dart';
import '../../repositories/models/room/room.dart';
import '../components/components.dart';
import 'tasks_page_state.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({
    super.key,
    required this.room,
  });
  final Room room;

  @override
  Widget build(BuildContext context) {
    final TasksPageBloc bloc = TasksPageBloc(selectedRoom: room)
      ..add(TaskPageOpened());
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: AppColors.darkWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: MyAppBar(
            canGoBack: true,
            title: room.name,
            onExit: () {
              context.pop(bloc.changeData.value);
            },
            haveButtons: false,
            underTitle: SizedBox(
              height: 45,
              child: CustomTextField(
                label: '',
                text: 'поиск',
                filledColor: AppColors.white,
                formzInput: null,
                hInt: 'search',
                suffixIcon: 'assets/icons/clear.svg',
                onChanged: (p0) {
                  bloc.add(SearchTask(value: p0));
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<TasksPageBloc, TaskPageState>(
          builder: (context, state) => state.inProcces
              ? const CircularProgressIndicator()
              : state.tasks.isEmpty
                  ? const Center(
                      child: Text('Пусто'),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        // bloc.add(PageUpdated());
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.tasks.length,
                        itemBuilder: (context, index) {
                          final item = state.tasks.elementAt(index);
                          return Dismissible(
                            key: Key(item.id!),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) => bloc.add(
                              DeleteTask(task: item),
                            ),
                            background: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: Container(
                                color: AppColors.red,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Удалить',
                                      style: AppTextStyles.headerStyle,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: TaskView(
                                data: item,
                                onTapSettings: (editingMode) async {
                                  final result = await context.push(
                                    AppRoute.task.path,
                                    extra: item,
                                  );

                                  if (result is Task) {
                                    bloc.add(
                                      EditTask(task: result),
                                    );
                                  }
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
        ),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () async {
            final result = await context.push(
              AppRoute.task.path,
              extra: null,
            );
            if (result is Task) {
              bloc.add(
                AddTask(
                  task: result,
                ),
              );
            }
          },
          /* onPressed: () {
            bloc.add(AddTask(
                task: Task(
              name: 'task_test',
              type: 1,
              status: 2,
              priority: 1,
              date: DateTime.now(),
              countRepeats: 0,
              countSkips: 0,
              dateUpdate: DateTime.now(),
            )));
          },*/
        ),
      ),
    );
  }
}
