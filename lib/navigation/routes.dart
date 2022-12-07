import 'package:equatable/equatable.dart';

class Routes extends Equatable {
  static const home = '/home';

  static const login = '/login';

  static const storagesMenu = '/home/storages';

  static const eventsMenu = '/home/events';

  static const calendar = '/home/calendar';

  static const admin = '/home/admin';

  static const event = '/home/events/event';

  static const storage = '/home/storages/storage';

  @override
  List<Object?> get props => [
        home,
        login,
        storagesMenu,
        eventsMenu,
        calendar,
        admin,
        storage,
        event,
      ];
}
