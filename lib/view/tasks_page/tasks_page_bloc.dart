import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/task/task.dart';
import 'package:home_tasks_app/use_cases/task_use_case.dart';
import 'package:home_tasks_app/view/tasks_page/tasks_page_events.dart';
import 'package:home_tasks_app/view/tasks_page/tasks_page_state.dart';

import '../../repositories/models/room/room.dart';
import '../../repositories/utils/exception.dart';

class TasksPageBloc extends Bloc<TaskPageEvent, TaskPageState> {
  TasksPageBloc({required this.selectedRoom})
      : super(
          TaskPageState(
            room: selectedRoom,
            tasks: List.empty(growable: true),
          ),
        ) {
    on<TaskPageOpened>(_onPageOpened);
    on<AddTask>(_onAddTask);
    on<DeleteTask>(_onDeleteTask);
    on<SearchTask>(_onSearchTask);
    on<EditTask>(_onEditTask);
  }
  final Room selectedRoom;
  late TaskUseCase _taskUseCase;
  late ValueNotifier<List<Task>> tasks;
  final ValueNotifier<bool> changeData = ValueNotifier(false);

  Future<void> _onPageOpened(
      TaskPageOpened event, Emitter<TaskPageState> emit) async {
    emit(state.copyWith(
      inProcces: true,
      room: selectedRoom,
    ));
    _taskUseCase = GetIt.instance<TaskUseCase>();

    try {
      final list = await _taskUseCase.getTask(selectedRoom.id!);
      tasks = ValueNotifier(list!);
      emit(state.copyWith(
        tasks: tasks.value,
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

  Future<void> _onAddTask(AddTask event, Emitter<TaskPageState> emit) async {
    try {
      final id = await _taskUseCase.addTask(
        roomId: selectedRoom.id!,
        task: event.task,
      );

      tasks = ValueNotifier(
        tasks.value
          ..add(
            event.task.copyWith(
              id: id,
            ),
          ),
      );

      emit(
        state.copyWith(
          inProcces: false,
          tasks: tasks.value,
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

  Future<void> _onDeleteTask(
      DeleteTask event, Emitter<TaskPageState> emit) async {
    try {
      await _taskUseCase.deleteTask(
        taskId: event.task.id!,
      );
      tasks = ValueNotifier(
        tasks.value
          ..remove(
            event.task,
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

  FutureOr<void> _onSearchTask(SearchTask event, Emitter<TaskPageState> emit) {
    emit(
      state.copyWith(
        inProcces: true,
      ),
    );
    try {
      final searchingList = tasks.value
          .where(
            (element) => element.name.contains(
              event.value,
            ),
          )
          .toList();
      emit(
        state.copyWith(inProcces: false, tasks: searchingList),
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

  Future<void> _onEditTask(EditTask event, Emitter<TaskPageState> emit) async {
    try {
      await _taskUseCase.editTask(
        roomId: selectedRoom.id!,
        task: event.task,
      );
      final index = tasks.value.indexWhere(
        (element) => element.id == event.task.id,
      );

      final list = tasks.value;
      list.removeAt(index);
      list.insert(
        index,
        event.task,
      );

      tasks.value = list;
      emit(
        state.copyWith(
          inProcces: false,
          tasks: tasks.value,
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
}
