// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../repositories/auth_repository.dart' as _i5;
import '../repositories/utils/dio.dart' as _i3;
import '../repositories/utils/token_controller.dart' as _i4;
import '../use_cases/authrorization_use_case.dart' as _i6;

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
    gh.singleton<_i5.AuthorizationRepository>(() => _i5.AuthorizationRepository(
          gh<_i3.MyDio>(),
          gh<_i4.TokenController>(),
        ));
    gh.factory<_i6.AuthorizationUseCase>(
        () => _i6.AuthorizationUseCase(gh<_i5.AuthorizationRepository>()));
    return this;
  }
}
