import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/repositories/utils/exception.dart';
import 'package:home_tasks_app/use_cases/group_use_case.dart';
import 'package:home_tasks_app/view/group_page/group_page_events.dart';
import 'package:home_tasks_app/view/groupes_page/groupes_page_events.dart';
import 'package:home_tasks_app/view/groupes_page/groupes_page_state.dart';

class GroupPageBloc extends Bloc<GroupPageEvent, GroupPageState> {
  GroupPageBloc()
      : super(
          GroupPageState(
            groupes: List.empty(growable: true),
          ),
        ) {
    on<GroupPageOpened>(_onGroupPageOpened);
    on<AddGroup>(_onAdd);
    on<EditGroup>(_onEditGroup);
    on<SearchGroup>(_onSearchGroup);
    on<DeleteGroup>(_onDeleteGroup);
    on<PageUpdated>(_onPageUpdate);
  }

  late GroupUseCase groupUseCase;
  late ValueNotifier<List<GroupOfRooms>> groupes;
  final ValueNotifier<bool> changeData = ValueNotifier(false);

  Future<void> _onGroupPageOpened(
      GroupPageOpened event, Emitter<GroupPageState> emit) async {
    emit(state.copyWith(
      inProcces: true,
    ));
    groupUseCase = GetIt.instance<GroupUseCase>();

    try {
      final list = await groupUseCase.getPublishGroupes();
      groupes = ValueNotifier(list!);
      emit(state.copyWith(
        groupes: groupes.value,
        inProcces: false,
      ));
    } catch (error) {
      emit(
        state.copyWith(
          inProcces: false,
          message:
              error is AppException ? error.getMessage() : error.toString(),
        ),
      );
    }
  }

  Future<void> _onAdd(AddGroup event, Emitter<GroupPageState> emit) async {
    try {
      final id = await groupUseCase.addGroup(
        name: event.group.name,
        describtion: event.group.describtion,
      );

      groupes = ValueNotifier(
        groupes.value
          ..add(
            event.group.copyWith(id: id),
          ),
      );

      emit(
        state.copyWith(inProcces: false, groupes: groupes.value),
      );
      changeData.value = true;
    } catch (error) {
      emit(
        state.copyWith(
          inProcces: false,
          message:
              error is AppException ? error.getMessage() : error.toString(),
        ),
      );
    }
  }

  Future<void> _onEditGroup(
      EditGroup event, Emitter<GroupPageState> emit) async {
    try {
      await groupUseCase.editGroup(
        groupId: event.group.id!,
        name: event.group.name,
        describtion: event.group.describtion,
      );
      final index = groupes.value.indexWhere(
        (element) => element.id == event.group.id,
      );

      final list = groupes.value;
      list.removeAt(index);
      list.insert(
        index,
        event.group,
      );

      groupes.value = list;
      emit(
        state.copyWith(inProcces: false, groupes: groupes.value),
      );
      changeData.value = true;
    } catch (error) {
      emit(
        state.copyWith(
          inProcces: false,
          message:
              error is AppException ? error.getMessage() : error.toString(),
        ),
      );
    }
  }

  Future<void> _onSearchGroup(
      SearchGroup event, Emitter<GroupPageState> emit) async {
    emit(
      state.copyWith(
        inProcces: true,
      ),
    );
    try {
      final searchingList = groupes.value
          .where(
            (element) => element.name.contains(
              event.value,
            ),
          )
          .toList();
      emit(
        state.copyWith(inProcces: false, groupes: searchingList),
      );
    } catch (error) {
      emit(
        state.copyWith(
          inProcces: false,
          message:
              error is AppException ? error.getMessage() : error.toString(),
        ),
      );
    }
  }

  Future<void> _onDeleteGroup(
      DeleteGroup event, Emitter<GroupPageState> emit) async {
    try {
      final id = await groupUseCase.deleteGroup(
        groupId: event.group.id!,
      );
      groupes = ValueNotifier(
        groupes.value
          ..remove(
            event.group,
          ),
      );

      changeData.value = true;
    } catch (error) {
      emit(
        state.copyWith(
          inProcces: false,
          message:
              error is AppException ? error.getMessage() : error.toString(),
        ),
      );
    }
  }

  Future<void> _onPageUpdate(
      PageUpdated event, Emitter<GroupPageState> emit) async {
    emit(state.copyWith(inProcces: true));
    try {
      final list = await groupUseCase.getPublishGroupes();
      groupes = ValueNotifier(list!);
      await Future.delayed(
        const Duration(seconds: 2),
      );
      emit(state.copyWith(
        groupes: groupes.value,
        inProcces: false,
      ));
    } catch (error) {
      emit(
        state.copyWith(
          inProcces: false,
          message:
              error is AppException ? error.getMessage() : error.toString(),
        ),
      );
    }
  }
}
