import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/screen/calendar/calendar_data.dart';
import 'package:the_sss_store/screen/calendar/calendar_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';

class CalendarScreenRoute extends AppRoute {
  CalendarScreenRoute()
      : super(
          path: '/home/calendar',
          builder: (context, state) => CalendarScreen(key: state.pageKey),
        );
}

class CalendarScreen extends Screen {
  const CalendarScreen({Key? key}) : super(key: key);

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState
    extends ScreenState<CalendarScreen, CalendarViewModel, CalendarData> {

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
        title: const Text('Calendário'),
      ),
    );
  }

}
