import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:home_tasks_app/navigation/routes.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/view/home_page/home_page_bloc.dart';
import 'package:home_tasks_app/view/home_page/home_page_events.dart';
import '../../repositories/models/room/room.dart';
import '../../theme/theme.dart';
import '../components/components.dart';
import 'home_page_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    RoomPageBloc bloc = RoomPageBloc()..add(RoomPageOpened());
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: AppColors.darkWhite,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(100),
          child: BlocBuilder<RoomPageBloc, RoomPageState>(
            builder: (context, state) => MyAppBar(
              title: 'Помещение:',
              haveButtons: true,
              underTitle: MyDropDownButton(
                setDefault: state.groupes.isNotEmpty,
                onChanged: (p0) {
                  if (p0 is GroupOfRooms) {
                    bloc.add(
                      SwapGroup(group: p0),
                    );
                  }
                },
                selectedValue: state.selectedGroup,
                content: state.groupes,
              ),
              onTapSettings: () async {
                final result = await context.push(
                  AppRoute.groupes.path,
                );
                if (result is bool && result) {
                  bloc.add(UpdatePage());
                }
              },
            ),
          ),
        ),
        body: CustomScrollView(slivers: [
          SliverToBoxAdapter(
            child: BlocBuilder<RoomPageBloc, RoomPageState>(
                builder: (context, state) => Center(
                        child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 20,
                      ),
                      child: Text(state.selectedGroup?.describtion ?? ""),
                    ))),
          ),
          BlocBuilder<RoomPageBloc, RoomPageState>(
            builder: (context, state) => state.inProcces
                ? const SliverToBoxAdapter(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : state.rooms.isEmpty
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: Text('Пусто'),
                        ),
                      )
                    : SliverList.builder(
                        itemCount: state.rooms.length,
                        itemBuilder: (context, index) {
                          final item = state.rooms.elementAt(index);
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Dismissible(
                              key: Key(item.id!),
                              direction: DismissDirection.endToStart,
                              onDismissed: (direction) => bloc.add(
                                DeleteRoom(room: item),
                              ),
                              background: Container(
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
                              child: GestureDetector(
                                onTap: () async {
                                  final result = await context.push(
                                    AppRoute.tasks.path,
                                    extra: item,
                                  );
                                },
                                child: GroupOfRoomsAndRoomsView(
                                  data: item,
                                  onTapSettings: (fullEditting) async {
                                    final result = await context.push(
                                      AppRoute.room.path,
                                      extra: item,
                                    );
                                    if (result is Room) {
                                      bloc.add(
                                        EditRoom(room: result),
                                      );
                                    }
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ]),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () async {
            final result = await context.push(
              AppRoute.room.path,
              extra: null,
            );
            if (result is Room) {
              bloc.add(
                AddRoom(room: result),
              );
            }
          },
        ),
      ),
    );
  }
}
