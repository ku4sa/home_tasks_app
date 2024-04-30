import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/repositories/utils/exception.dart';
import 'package:home_tasks_app/use_cases/group_use_case.dart';
import 'package:home_tasks_app/use_cases/room_use_case.dart';

import '../../repositories/models/room/room.dart';
import 'home_page_events.dart';
import 'home_page_state.dart';

class RoomPageBloc extends Bloc<RoomPageEvent, RoomPageState> {
  RoomPageBloc()
      : super(
          RoomPageState(
              groupes: List.empty(growable: true),
              rooms: List.empty(growable: true)),
        ) {
    on<RoomPageOpened>(_onRoomPageOpened);
    on<AddRoom>(_onAdd);
    on<EditRoom>(_onEdit);
    on<SwapGroup>(_onSwap);
    on<DeleteRoom>(_onDelete);
    on<UpdatePage>(_onUpdatePage);
  }

  late GroupUseCase groupUseCase;
  late RoomUseCase roomUseCase;
  late ValueNotifier<List<Room>> rooms;
  late List<GroupOfRooms> groupes;

  Future<void> _onRoomPageOpened(
      RoomPageOpened event, Emitter<RoomPageState> emit) async {
    emit(state.copyWith(
      inProcces: true,
    ));

    groupUseCase = GetIt.instance<GroupUseCase>()..init();
    roomUseCase = GetIt.instance<RoomUseCase>()..init();

    try {
      groupes = await groupUseCase.getPublishGroupes() ?? [];
      if (groupes.isEmpty) throw Exception("list of groupes empty");
      final list = await roomUseCase.getRoom(groupes.first.id!);
      print("ok");
      rooms = ValueNotifier(list!);
      await groupUseCase.selectGroup(groupes.first);

      emit(
        state.copyWith(
          inProcces: false,
          groupes: groupes,
          selectedGroup: groupUseCase.getActiveGroup(),
          rooms: rooms.value,
        ),
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

  Future<void> _onAdd(AddRoom event, Emitter<RoomPageState> emit) async {
    try {
      final id = await roomUseCase.addRoom(
        groupId: state.selectedGroup!.id!,
        name: event.room.name,
        describtion: event.room.describtion,
      );
      rooms = ValueNotifier(
        rooms.value
          ..add(
            event.room.copyWith(id: id),
          ),
      );
      emit(
        state.copyWith(
          rooms: rooms.value,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          message:
              error is AppException ? error.getMessage() : error.toString(),
        ),
      );
    }
  }

  Future<void> _onEdit(EditRoom event, Emitter<RoomPageState> emit) async {
    try {
      await roomUseCase.editRoom(
        roomId: event.room.id!,
        name: event.room.name,
        describtion: event.room.describtion,
      );
      final index = rooms.value.indexWhere(
        (element) => element.id == event.room.id,
      );

      final list = rooms.value;
      list.removeAt(index);
      list.insert(
        index,
        event.room,
      );

      rooms.value = list;
      emit(
        state.copyWith(inProcces: false, rooms: rooms.value),
      );
      //changeData.value = true;
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

  Future<void> _onSwap(SwapGroup event, Emitter<RoomPageState> emit) async {
    try {
      rooms = ValueNotifier((await roomUseCase.getRoom(event.group.id!)) ?? []);
      await groupUseCase.selectGroup(event.group);
      emit(
        state.copyWith(
          inProcces: false,
          selectedGroup: groupUseCase.getActiveGroup(),
          rooms: rooms.value,
        ),
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

  Future<void> _onDelete(DeleteRoom event, Emitter<RoomPageState> emit) async {
    try {
      await roomUseCase.deleteRoom(
        roomId: event.room.id!,
      );
      rooms = ValueNotifier(
        rooms.value
          ..remove(
            event.room,
          ),
      );

      //changeData.value = true;
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

  Future<void> _onUpdatePage(
      UpdatePage event, Emitter<RoomPageState> emit) async {
    try {
      groupes = await groupUseCase.getPublishGroupes() ?? [];
      if (groupes.isEmpty) throw Exception("list of groupes empty");

      emit(
        state.copyWith(
          inProcces: false,
          groupes: groupes,
        ),
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
}
