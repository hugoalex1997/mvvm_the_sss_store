import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';
import 'package:provider/provider.dart';
import 'package:the_sss_store/widget/storage_button.dart';
import 'package:the_sss_store/screen/storage/storage_screen.dart';

class StoragesMenuScreenRoute extends AppRoute {
  StoragesMenuScreenRoute()
      : super(
          path: '/home/storages',
          builder: (context, state) => StoragesMenuScreen(key: state.pageKey),
        );
}

class StoragesMenuScreen extends Screen {
  const StoragesMenuScreen({Key? key}) : super(key: key);

  @override
  _StoragesMenuScreenState createState() => _StoragesMenuScreenState();
}

class _StoragesMenuScreenState extends ScreenState<StoragesMenuScreen,
    StoragesMenuViewModel, StoragesMenuData> {
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
        title: const Text('Armazéns'),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _StorageList(onTap: onButtonTap),
          const Center(child: _ProgressBar()),
          const _EmptyState(),
        ],
      ),
    );
  }

  void onButtonTap(String name) {
    StorageScreenRoute().push(context);
  }

}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<StoragesMenuData, bool>(
      selector: (_, data) => data.showLoading,
      builder: (context, showLoading, _) => Visibility(
        visible: showLoading,
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<StoragesMenuData, bool>(
      selector: (_, data) => data.showEmptyState,
      builder: (context, showEmptyState, _) => Visibility(
        visible: showEmptyState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Não foram encontrados Armazéns',
            style: Theme.of(context).textTheme.headline4,
          ),
        ),
      ),
    );
  }
}

class _StorageList extends StatelessWidget {
  const _StorageList({
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final Function(String) onTap;
  @override
  Widget build(BuildContext context) {
    return Selector<StoragesMenuData, List<StorageButtonData>>(
      selector: (_, data) => data.storageText,
      builder: (context, storageText, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = storageText[index];
            return TextButton(
              child: StorageText(name: data.name),
              onPressed: () {
                onTap(data.name);
              } 
            );
          },
          separatorBuilder: (_, __) => const Divider(),
          itemCount: storageText.length,
        );
      },
    );
  }
}
