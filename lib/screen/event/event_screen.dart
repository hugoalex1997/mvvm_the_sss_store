import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/event/event_data.dart';
import 'package:the_sss_store/screen/event/event_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';

class EventScreenRoute extends AppRoute {
  EventScreenRoute()
      : super(
          path: Routes.event,
          builder: (context, state) => EventScreen(key: state.pageKey),
        );
}

class EventScreen extends Screen {
  const EventScreen({Key? key}) : super(key: key);

  @override
  _EventScreenState createState() => _EventScreenState();
}

class _EventScreenState extends ScreenState<EventScreen,
    EventViewModel, EventData> {
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Evento'),
      ),
      body: Container(),
    );
  }

}


