// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../factory/view_model_factory.dart' as _i16;
import '../repository/storages_menu_repository.dart' as _i14;
import '../screen/admin_menu/admin_menu_view_model.dart' as _i3;
import '../screen/calendar/calendar_view_model.dart' as _i4;
import '../screen/event/event_view_model.dart' as _i5;
import '../screen/events_menu/events_menu_view_model.dart' as _i6;
import '../screen/home/home_view_model.dart' as _i11;
import '../screen/login/login_view_model.dart' as _i12;
import '../screen/storage/storage_view_model.dart' as _i13;
import '../screen/storages_menu/storages_menu_view_model.dart' as _i15;
import '../services/firebase/firebase_events_api.dart' as _i7;
import '../services/firebase/firebase_init.dart' as _i8;
import '../services/firebase/firebase_storage_api.dart' as _i9;
import '../services/firebase/firebase_storages_menu_api.dart'
    as _i10; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AdminMenuViewModel>(() => _i3.AdminMenuViewModel());
  gh.factory<_i4.CalendarViewModel>(() => _i4.CalendarViewModel());
  gh.factory<_i5.EventViewModel>(() => _i5.EventViewModel());
  gh.factory<_i6.EventsMenuViewModel>(() => _i6.EventsMenuViewModel());
  gh.singleton<_i7.FirebaseEventsAPI>(_i7.FirebaseEventsAPI());
  gh.factory<_i8.FirebaseService>(() => _i8.FirebaseService());
  gh.singleton<_i9.FirebaseStorageAPI>(_i9.FirebaseStorageAPI());
  gh.singleton<_i10.FirebaseStoragesMenuAPI>(_i10.FirebaseStoragesMenuAPI());
  gh.factory<_i11.HomeViewModel>(() => _i11.HomeViewModel());
  gh.factory<_i12.LoginViewModel>(() => _i12.LoginViewModel());
  gh.factory<_i13.StorageViewModel>(() => _i13.StorageViewModel());
  gh.singleton<_i14.StoragesMenuRepository>(
      _i14.StoragesMenuRepository(get<_i10.FirebaseStoragesMenuAPI>()));
  gh.factory<_i15.StoragesMenuViewModel>(
      () => _i15.StoragesMenuViewModel(get<_i14.StoragesMenuRepository>()));
  gh.singleton<_i16.ViewModelFactory>(_i16.ViewModelFactoryImpl());
  return get;
}
