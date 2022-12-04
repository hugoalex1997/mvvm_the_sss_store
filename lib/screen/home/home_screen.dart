import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/home/home_data.dart';
import 'package:the_sss_store/screen/home/home_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_screen.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_screen.dart';
import 'package:the_sss_store/screen/calendar/calendar_screen.dart';
import 'package:the_sss_store/screen/admin_menu/admin_menu_screen.dart';
import 'package:the_sss_store/screen/login/login_screen.dart';


class HomeScreenRoute extends AppRoute {
  HomeScreenRoute()
      : super(
          path: Routes.home,
          builder: (context, state) => HomeScreen(key: state.pageKey),
        );
}

class HomeScreen extends Screen {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState
    extends ScreenState<HomeScreen, HomeViewModel, HomeData> {
  @override
  void initState() {
    super.initState();
    viewModel.init();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Menu')),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[
            StoragesMenuButton(),
            EventsMenuButton(),
            CalendarButton(),
            AdminButton(),
            LogoutButton(),
          ],
        ),
      ),
    );
  }
}

class StoragesMenuButton extends StatelessWidget {
  @visibleForTesting
  const StoragesMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: const Text("Armazéns"),
      color: Theme.of(context).colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
      onPressed: () => StoragesMenuScreenRoute().push(context),
    );
  }
}

class EventsMenuButton extends StatelessWidget {
  @visibleForTesting
  const EventsMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: const Text("Eventos"),
      color: Theme.of(context).colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
      onPressed: () => EventsMenuScreenRoute().push(context),
    );
  }
}

class CalendarButton extends StatelessWidget {
  @visibleForTesting
  const CalendarButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: const Text("Calendário"),
      color: Theme.of(context).colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
      onPressed: () => CalendarScreenRoute().push(context),
    );
  }
}

class AdminButton extends StatelessWidget {
  @visibleForTesting
  const AdminButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: const Text("Admin"),
      color: Theme.of(context).colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
      onPressed: () => AdminMenuScreenRoute().push(context),
    );
  }
}

class LogoutButton extends StatelessWidget {
  @visibleForTesting
  const LogoutButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      child: const Text("Logout"),
      color: Theme.of(context).colorScheme.primary,
      textTheme: ButtonTextTheme.primary,
      onPressed: () => LoginScreenRoute().pushAndReplacement(context),
    );
  }
}
