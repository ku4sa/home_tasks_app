import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/theme/theme.dart';
import 'package:home_tasks_app/view/groupes_page/groupes_page_bloc.dart';
import 'package:home_tasks_app/view/groupes_page/groupes_page_events.dart';
import '../components/components.dart';
import 'groupes_page_state.dart';

class GroupesPage extends StatelessWidget {
  const GroupesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupPageBloc bloc = GroupPageBloc()..add(GroupPageOpened());
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: AppColors.darkWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: MyAppBar(
            canGoBack: true,
            title: 'Мои помещения',
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
                  bloc.add(SearchGroup(value: p0));
                },
              ),
            ),
          ),
        ),
        body: BlocBuilder<GroupPageBloc, GroupPageState>(
          builder: (context, state) => state.inProcces
              ? const CircularProgressIndicator()
              : state.groupes.isEmpty
                  ? const Center(
                      child: Text('Пусто'),
                    )
                  : RefreshIndicator(
                      onRefresh: () async {
                        bloc.add(PageUpdated());
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: state.groupes.length,
                        itemBuilder: (context, index) {
                          final item = state.groupes.elementAt(index);
                          return Dismissible(
                            key: Key(item.id!),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) => bloc.add(
                              DeleteGroup(group: item),
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
                              child: GroupOfRoomsAndRoomsView(
                                isRoom: false,
                                data: item,
                                onTapSettings: () async {
                                  final result = await context
                                      .push(AppRoute.group.path, extra: item);

                                  if (result is GroupOfRooms) {
                                    bloc.add(EditGroup(group: result));
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
              AppRoute.group.path,
            );
            if (result is GroupOfRooms) {
              bloc.add(AddGroup(group: result));
            }
          },
        ),
      ),
    );
  }
}
