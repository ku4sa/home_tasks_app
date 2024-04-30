import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_tasks_app/repositories/models/room/room.dart';
import 'package:home_tasks_app/repositories/utils/validator.dart';
import 'package:home_tasks_app/use_cases/room_use_case.dart';
import 'room_page_events.dart';
import 'room_page_state.dart';

class RoomEditorPageBloc
    extends Bloc<RoomEditorPageEvent, RoomEditorPageState> {
  RoomEditorPageBloc()
      : super(
          RoomEditorPageState(),
        ) {
    on<EditorOpened>(_onEditorOpened);
    on<CreatorOpened>(_onCreatorOpened);
    on<ChangeName>(_onChangeName);
    on<ChangeDescribtion>(_onChangeDescribtion);
    on<ImportSettings>(_onImportSettings);
  }

  late RoomUseCase roomUseCase;
  final ValueNotifier<bool> changeData = ValueNotifier(false);

  Future<void> _onChangeName(
      ChangeName event, Emitter<RoomEditorPageState> emit) async {
    emit(
      state.copyWith(
        room: state.room!.copyWith(name: event.name),
        isValid: Validator.validateName(event.name) == null &&
            Validator.validateDescription(state.room!.describtion) == null,
      ),
    );
  }

  Future<void> _onChangeDescribtion(
      ChangeDescribtion event, Emitter<RoomEditorPageState> emit) async {
    emit(
      state.copyWith(
        room: state.room!.copyWith(describtion: event.describtion),
        isValid: Validator.validateName(state.room!.name) == null &&
            Validator.validateDescription(event.describtion) == null,
      ),
    );
  }

  FutureOr<void> _onEditorOpened(
      EditorOpened event, Emitter<RoomEditorPageState> emit) {
    emit(
      state.copyWith(
        room: event.room,
        isValid: true,
      ),
    );
    roomUseCase = GetIt.instance<RoomUseCase>();
  }

  FutureOr<void> _onCreatorOpened(
      CreatorOpened event, Emitter<RoomEditorPageState> emit) {
    final group = Room(
      id: "",
      describtion: "",
      name: "",
      dateUpdate: DateTime.now(),
      tasks: [],
    );
    roomUseCase = GetIt.instance<RoomUseCase>();
    emit(
      state.copyWith(
        room: group,
        isValid: false,
      ),
    );
  }

  FutureOr<void> _onImportSettings(
      ImportSettings event, Emitter<RoomEditorPageState> emit) {
    final room = Room(
      id: "",
      describtion: event.room.describtion,
      name: event.room.name,
      dateUpdate: DateTime.now(),
      tasks: [],
    );
    emit(
      state.copyWith(
        room: room,
        isValid: true,
      ),
    );
  }
}
