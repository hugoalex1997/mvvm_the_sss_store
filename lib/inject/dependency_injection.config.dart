// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../factory/view_model_factory.dart' as _i17;
import '../repository/events_menu_repository.dart' as _i18;
import '../repository/storage_repository.dart' as _i13;
import '../repository/storages_menu_repository.dart' as _i15;
import '../screen/admin_menu/admin_menu_view_model.dart' as _i3;
import '../screen/calendar/calendar_view_model.dart' as _i4;
import '../screen/event/event_view_model.dart' as _i5;
import '../screen/events_menu/events_menu_view_model.dart' as _i19;
import '../screen/home/home_view_model.dart' as _i11;
import '../screen/login/login_view_model.dart' as _i12;
import '../screen/storage/storage_view_model.dart' as _i14;
import '../screen/storages_menu/storages_menu_view_model.dart' as _i16;
import '../services/firebase/firebase_event_api.dart' as _i9;
import '../services/firebase/firebase_events_menu_api.dart' as _i6;
import '../services/firebase/firebase_init.dart' as _i7;
import '../services/firebase/firebase_storage_api.dart' as _i8;
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
  gh.singleton<_i6.FirebaseEventsMenuAPI>(_i6.FirebaseEventsMenuAPI());
  gh.factory<_i7.FirebaseService>(() => _i7.FirebaseService());
  gh.singleton<_i8.FirebaseStorageAPI>(_i8.FirebaseStorageAPI());
  gh.singleton<_i9.FirebaseStorageAPI>(_i9.FirebaseStorageAPI());
  gh.singleton<_i10.FirebaseStoragesMenuAPI>(_i10.FirebaseStoragesMenuAPI());
  gh.factory<_i11.HomeViewModel>(() => _i11.HomeViewModel());
  gh.factory<_i12.LoginViewModel>(() => _i12.LoginViewModel());
  gh.singleton<_i13.StorageRepository>(
      _i13.StorageRepository(get<_i8.FirebaseStorageAPI>()));
  gh.factory<_i14.StorageViewModel>(
      () => _i14.StorageViewModel(get<_i13.StorageRepository>()));
  gh.singleton<_i15.StoragesMenuRepository>(
      _i15.StoragesMenuRepository(get<_i10.FirebaseStoragesMenuAPI>()));
  gh.factory<_i16.StoragesMenuViewModel>(
      () => _i16.StoragesMenuViewModel(get<_i15.StoragesMenuRepository>()));
  gh.singleton<_i17.ViewModelFactory>(_i17.ViewModelFactoryImpl());
  gh.singleton<_i18.EventsMenuRepository>(
      _i18.EventsMenuRepository(get<_i6.FirebaseEventsMenuAPI>()));
  gh.factory<_i19.EventsMenuViewModel>(
      () => _i19.EventsMenuViewModel(get<_i18.EventsMenuRepository>()));
  return get;
}
