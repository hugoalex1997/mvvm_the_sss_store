import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/admin_menu/admin_menu_data.dart';
import 'package:the_sss_store/screen/admin_menu/admin_menu_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';

class AdminMenuScreenRoute extends AppRoute {
  AdminMenuScreenRoute()
      : super(
          path: Routes.admin,
          builder: (context, state) => AdminMenuScreen(key: state.pageKey),
        );
}

class AdminMenuScreen extends Screen {
  const AdminMenuScreen({Key? key}) : super(key: key);

  @override
  _AdminMenuScreenState createState() => _AdminMenuScreenState();
}

class _AdminMenuScreenState
    extends ScreenState<AdminMenuScreen, AdminMenuViewModel, AdminMenuData> {
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
        title: const Text('Admin'),
      ),
    );
  }
}
