import 'package:go_router/go_router.dart';
import 'package:the_sss_store/navigation/routes.dart';

import 'package:the_sss_store/screen/login/login_screen.dart';
import 'package:the_sss_store/screen/home/home_screen.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_screen.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_screen.dart';
import 'package:the_sss_store/screen/calendar/calendar_screen.dart';
import 'package:the_sss_store/screen/admin_menu/admin_menu_screen.dart';
import 'package:the_sss_store/screen/storage/storage_screen.dart';
import 'package:the_sss_store/screen/event/event_screen.dart';

GoRouter createRouter([String? initialRoute]) {
  return GoRouter(
    initialLocation: initialRoute ?? Routes.home,
    routes: [
      LoginScreenRoute(),
      HomeScreenRoute(),
      StoragesMenuScreenRoute(),
      EventsMenuScreenRoute(),
      CalendarScreenRoute(),
      AdminMenuScreenRoute(),
      StorageScreenRoute(),
      EventScreenRoute()
    ],
  );
}

GoRouter router([String? initialLocation]) {
  return createRouter(initialLocation);
}
