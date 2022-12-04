import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';
import 'package:the_sss_store/screen/storage/storage_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';

class StorageScreenRoute extends AppRoute {
  StorageScreenRoute()
      : super(
          path: Routes.storage,
          builder: (context, state) => StorageScreen(key: state.pageKey),
        );
}

class StorageScreen extends Screen {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState extends ScreenState<StorageScreen,
    StorageViewModel, StorageData> {
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
        title: const Text('Armazém'),
      ),
      body: Container(),
    );
  }

}


