import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/group_of_rooms/group_of_rooms.dart';
import 'package:home_tasks_app/repositories/utils/exception.dart';
import 'package:home_tasks_app/use_cases/group_use_case.dart';
import 'package:home_tasks_app/view/authorization_page/models/describtion.dart';

import '../authorization_page/models/models.dart';
import 'group_page_events.dart';
import 'group_page_state.dart';

class GroupEditorPageBloc
    extends Bloc<GroupEditorPageEvent, GroupEditorPageState> {
  GroupEditorPageBloc()
      : super(
          GroupEditorPageState(
            name: Name.pure(),
            describtion: Describtion.pure(),
          ),
        ) {
    on<AddUser>(_onAddUser);

    on<EditorOpened>(_onEditorOpened);
    on<CreatorOpened>(_onCreatorOpened);
    on<DeleteUser>(_deleteUser);
    on<ChangeName>(_onChangeName);
    on<ChangeDescribtion>(_onChangeDescribtion);
    on<ImportSettings>(_onImportSettings);
  }

  late GroupUseCase groupUseCase;
  late ValueNotifier<List<GroupOfRooms>> groupes;
  final ValueNotifier<bool> changeData = ValueNotifier(false);



  Future<void> _onAddUser(
      AddUser event, Emitter<GroupEditorPageState> emit) async {
    try {
      await groupUseCase.addUserToGroupOfRoom(
          username: event.username, groupId: state.group!.id!);
      emit(
        state.copyWith(
          group: state.group!.copyWith(
            users: state.group!.users..add(event.username),
          ),
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

  Future<void> _deleteUser(
      DeleteUser event, Emitter<GroupEditorPageState> emit) async {
    try {
      await groupUseCase.deleteUserFromGroupOfRoom(
          username: event.username, groupId: state.group!.id!);
      emit(
        state.copyWith(
          group: state.group!.copyWith(
            users: state.group!.users..remove(event.username),
          ),
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

  Future<void> _onChangeName(
      ChangeName event, Emitter<GroupEditorPageState> emit) async {
    emit(
      state.copyWith(
        name: Name.pure(event.name),
        group: state.group!.copyWith(name: event.name),
        isValid: Formz.validate([Name.dirty(event.name), state.describtion]),
      ),
    );
  }

  Future<void> _onChangeDescribtion(
      ChangeDescribtion event, Emitter<GroupEditorPageState> emit) async {
    emit(
      state.copyWith(
        describtion: Describtion.pure(event.describtion),
        group: state.group!.copyWith(describtion: event.describtion),
        isValid: Formz.validate([
          state.name,
          Describtion.pure(event.describtion),
        ]),
      ),
    );
  }

  FutureOr<void> _onEditorOpened(
      EditorOpened event, Emitter<GroupEditorPageState> emit) {
    emit(
      state.copyWith(
        group: event.group,
        name: Name.pure(
          event.group.name,
        ),
        describtion: Describtion.pure(event.group.describtion ?? ""),
      ),
    );
    groupUseCase = GetIt.instance<GroupUseCase>();
  }

  FutureOr<void> _onCreatorOpened(
      CreatorOpened event, Emitter<GroupEditorPageState> emit) {
    final group = GroupOfRooms(
      id: "",
      author: "",
      describtion: "",
      name: "",
      dateUpdate: DateTime.now(),
      users: [],
      rooms: [],
    );
    groupUseCase = GetIt.instance<GroupUseCase>();
    emit(
      state.copyWith(
        group: group,
        name: Name.pure(group.name),
        describtion: Describtion.pure(
          group.describtion ?? "",
        ),
      ),
    );
  }

  FutureOr<void> _onImportSettings(
      ImportSettings event, Emitter<GroupEditorPageState> emit) {
    final group = GroupOfRooms(
      id: "",
      author: "",
      describtion: event.group.describtion,
      name: event.group.name,
      dateUpdate: DateTime.now(),
      users: [],
      rooms: [],
    );
    emit(
      state.copyWith(
        name: Name.pure(group.name),
        describtion: Describtion.pure(
          group.describtion ?? "",
        ),
        group: group,
      ),
    );
  }
}
