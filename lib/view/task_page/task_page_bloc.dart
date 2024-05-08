import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/interval/interval.dart';
import '../../repositories/auth_repository.dart';
import '../../repositories/group_repository.dart';
import '../../repositories/models/task/task.dart';
import '../../repositories/models/task_type/task_type.dart';
import '../../repositories/models/user/user.dart';
import '../../repositories/utils/validator.dart';
import 'task_page_events.dart';
import 'task_page_state.dart';

class TaskEditorPageBloc extends Bloc<TaskEditorEvents, TaskEditorPageState> {
  TaskEditorPageBloc()
      : super(
          TaskEditorPageState(),
        ) {
    on<EditorOpened>(_onEditorOpened);
    on<CreatorOpened>(_onCreatorOpened);
    on<ChangeName>(_onChangeName);
    on<ChangeDescribtion>(_onChangeDescribtion);
    on<ImportSettings>(_onImportSettings);
    on<ChangeActiveUser>(_onChangeActiveUser);
    on<ChangeLeadTime>(_onChangeLeadTime);
    on<ChangeDate>(_onChangeDate);
    on<ChangeTaskType>(_onChangeTaskType);
    on<ChangeStatus>(_onChangeStatus);
    on<ChangeInterval>(_onChangeInterval);
    on<ChangePriority>(_onChangePriority);
  }

  final ValueNotifier<bool> changeData = ValueNotifier(false);
  final ValueNotifier<DateTime?> selectedDate = ValueNotifier(null);
  final ValueNotifier<TaskType?> selectedType = ValueNotifier(null);
  final users = GetIt.instance<GroupRepository>().getUsersWithAuthor();

  int getTypeValue() {
    switch (state.typeValue) {
      case 1:
        return 0;
      case 7:
        return 1;
      case 30:
        return 2;
      case 365:
        return 3;
      default:
        return 0;
    }
  }

  bool canChooseExecuter() {
    return users != null && users!.length > 1;
  }

  User? selectedExecutor(String? user) {
    return user != null
        ? users!.firstWhere((element) => element.username == user)
        : users!.firstWhere(
            (element) =>
                element.username ==
                GetIt.instance<AuthorizationRepository>()
                    .activeUser
                    .value!
                    .username,
          );
  }

  FutureOr<void> _onEditorOpened(
      EditorOpened event, Emitter<TaskEditorPageState> emit) {
    selectedDate.value = event.task.date;

    selectedType.value = TaskType(type: event.task.type);

    if (event.task.type == 2) {
      final interval = event.task.getIntervalView();
      if (interval != null)
        emit(
          state.copyWith(
            task: event.task,
            isValid: true,
            typeValue: interval.keys.first,
            countValue: interval.values.first,
          ),
        );
    }

    // _taskUseCase = GetIt.instance<TaskUseCase>();
  }

  FutureOr<void> _onCreatorOpened(
      CreatorOpened event, Emitter<TaskEditorPageState> emit) {
    final task = Task(
      name: "",
      type: 1,
      status: 1,
      priority: 1,
      date: DateTime.now(),
      countRepeats: 0,
      countSkips: 0,
      dateUpdate: DateTime.now(),
    );
    emit(
      state.copyWith(
        task: task,
        isValid: false,
        typeValue: 1,
      ),
    );

    selectedType.value = TaskType(type: 1);
    // _taskUseCase = GetIt.instance<TaskUseCase>();
  }

  FutureOr<void> _onChangeName(
      ChangeName event, Emitter<TaskEditorPageState> emit) {
    emit(
      state.copyWith(
        task: state.task!.copyWith(name: event.name),
        isValid: Validator.validateName(event.name) == null &&
            Validator.validateDescription(state.task!.describtion) == null &&
            state.task?.priority != 0,
      ),
    );
    changeData.value = true;
  }

  FutureOr<void> _onChangeDescribtion(
      ChangeDescribtion event, Emitter<TaskEditorPageState> emit) {
    emit(
      state.copyWith(
        task: state.task!.copyWith(describtion: event.describtion),
        isValid: Validator.validateName(state.task!.name) == null &&
            Validator.validateDescription(event.describtion) == null &&
            state.task?.priority != 0,
      ),
    );
    changeData.value = true;
  }

  FutureOr<void> _onImportSettings(
      ImportSettings event, Emitter<TaskEditorPageState> emit) {
    emit(
      state.copyWith(
        task: event.task.copyWith(
          countRepeats: 0,
          countSkips: 0,
          id: "",
          dateUpdate: DateTime.now(),
        ),
        isValid: true,
      ),
    );
    changeData.value = true;
  }

  Future<void> _onChangeLeadTime(
      ChangeLeadTime event, Emitter<TaskEditorPageState> emit) async {
    final value = int.tryParse(event.time);

    emit(
      state.copyWith(
        task: state.task!.copyWith(
          leadTime: value != null
              ? IntervalType(
                  minutes: value,
                )
              : null,
        ),
        isValid: Validator.validateName(
                  state.task!.name,
                ) ==
                null &&
            Validator.validateDescription(state.task!.describtion) == null &&
            value != null,
      ),
    );

    changeData.value = true;
  }

  FutureOr<void> _onChangeActiveUser(
      ChangeActiveUser event, Emitter<TaskEditorPageState> emit) {
    emit(
      state.copyWith(
        task: state.task!.copyWith(user: event.user.name),
      ),
    );
    changeData.value = true;
  }

  FutureOr<void> _onChangeDate(
      ChangeDate event, Emitter<TaskEditorPageState> emit) {
    selectedDate.value = event.time;
    emit(
      state.copyWith(
        task: state.task!.copyWith(
          date: event.time,
        ),
      ),
    );
  }

  FutureOr<void> _onChangeTaskType(
      ChangeTaskType event, Emitter<TaskEditorPageState> emit) {
    selectedType.value = event.type;

    emit(
      state.copyWith(
        task: state.task?.copyWith(
          type: event.type.type,
        ),
        isValid:
            state.isValid && (event.type.type == 1 || event.type.type == 2),
      ),
    );
  }

  FutureOr<void> _onChangeStatus(
      ChangeStatus event, Emitter<TaskEditorPageState> emit) {
    emit(
      state.copyWith(
        task: state.task?.copyWith(
          status: event.status.status,
        ),
      ),
    );
  }

  FutureOr<void> _onChangeInterval(
      ChangeInterval event, Emitter<TaskEditorPageState> emit) {
    IntervalType? duration = state.task!.interval;
    emit(
      state.copyWith(
        typeValue: event.type ?? state.typeValue,
        countValue: event.interval ?? state.countValue,
      ),
    );
    if (state.typeValue != null && state.countValue != null) {
      duration = IntervalType(
        days: state.countValue! * state.typeValue!,
      );
    }
    print(duration);

    emit(
      state.copyWith(
        task: state.task!.copyWith(
          interval: duration,
          date: duration != null //пересчитываем следующую дату выполнения
              ? DateTime.now().add(duration.toDuration())
              : state.task!.date,
        ),
      ),
    );
  }

  FutureOr<void> _onChangePriority(
      ChangePriority event, Emitter<TaskEditorPageState> emit) {
    emit(
      state.copyWith(
        task: state.task!.copyWith(
          priority: event.priority,
        ),
        isValid: state.isValid && event.priority != 0,
      ),
    );
  }
}
