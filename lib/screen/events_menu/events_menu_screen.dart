import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';

class EventsMenuScreenRoute extends AppRoute {
  EventsMenuScreenRoute()
      : super(
          path: Routes.eventsMenu,
          builder: (context, state) => EventsMenuScreen(key: state.pageKey),
        );
}

class EventsMenuScreen extends Screen {
  const EventsMenuScreen({Key? key}) : super(key: key);

  @override
  _EventsMenuScreenState createState() => _EventsMenuScreenState();
}

class _EventsMenuScreenState
    extends ScreenState<EventsMenuScreen, EventsMenuViewModel, EventsMenuData> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eventos'),
      ),
    );
  }

}
