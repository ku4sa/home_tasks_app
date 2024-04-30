// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../repositories/auth_repository.dart' as _i8;
import '../repositories/group_repository.dart' as _i5;
import '../repositories/room_repository.dart' as _i6;
import '../repositories/task_repository.dart' as _i7;
import '../repositories/utils/dio.dart' as _i3;
import '../repositories/utils/token_controller.dart' as _i4;
import '../use_cases/authrorization_use_case.dart' as _i9;
import '../use_cases/group_use_case.dart' as _i11;
import '../use_cases/room_use_case.dart' as _i10;
import '../use_cases/task_use_case.dart' as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.MyDio>(() => _i3.MyDio());
    gh.singleton<_i4.TokenController>(() => _i4.TokenController());
    gh.singleton<_i5.GroupRepository>(() => _i5.GroupRepository());
    gh.singleton<_i6.RoomRepository>(() => _i6.RoomRepository());
    gh.singleton<_i7.TaskRepository>(() => _i7.TaskRepository());
    gh.singleton<_i8.AuthorizationRepository>(() => _i8.AuthorizationRepository(
          gh<_i3.MyDio>(),
          gh<_i4.TokenController>(),
        ));
    gh.factory<_i9.AuthorizationUseCase>(
        () => _i9.AuthorizationUseCase(gh<_i8.AuthorizationRepository>()));
    gh.factory<_i10.RoomUseCase>(
        () => _i10.RoomUseCase(gh<_i6.RoomRepository>()));
    gh.factory<_i11.GroupUseCase>(
        () => _i11.GroupUseCase(gh<_i5.GroupRepository>()));
    gh.factory<_i12.TaskUseCase>(
        () => _i12.TaskUseCase(gh<_i7.TaskRepository>()));
    return this;
  }
}
