import 'package:flutter/material.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';
import 'package:provider/provider.dart';
import 'package:the_sss_store/screen/storage/storage_screen.dart';

class StoragesMenuScreenRoute extends AppRoute {
  StoragesMenuScreenRoute()
      : super(
          path: Routes.storagesMenu,
          builder: (context, state) => StoragesMenuScreen(key: state.pageKey),
        );
}

class StoragesMenuScreen extends Screen {
  const StoragesMenuScreen({Key? key}) : super(key: key);

  @override
  _StoragesMenuScreenState createState() => _StoragesMenuScreenState();
}

class _StoragesMenuScreenState extends ScreenState<StoragesMenuScreen, StoragesMenuViewModel, StoragesMenuData> {
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
        actions: [
          _SettingsButton(viewModel: viewModel),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          _StorageList(
            onTap: _onStorageButtonTap,
            storageButtonStyle: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
            ),
          ),
          const Center(child: _ProgressBar()),
          const _EmptyState(),
          _StorageMenuPopup(viewModel: viewModel),
        ],
      ),
    );
  }

  void _onStorageButtonTap(String name) {
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

class _SettingsButton extends StatelessWidget {
  const _SettingsButton({required this.viewModel, Key? key}) : super(key: key);

  final StoragesMenuViewModel viewModel;

  void _onAddStorageButtonTap() {
    viewModel.showAddStoragePopup();
  }

  void _onRemoveStorageButtonTap() {
    viewModel.showRemoveStoragePopup();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: _AddStorageSettingsButton(onTap: () {
              _onAddStorageButtonTap();
              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: _RemoveStorageSettingsButton(onTap: () {
              _onRemoveStorageButtonTap();
              Navigator.pop(context);
            }),
          ),
        ];
      },
    );
  }
}

class _AddStorageSettingsButton extends StatelessWidget {
  const _AddStorageSettingsButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      child: const Text("Adicionar armazém"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class _RemoveStorageSettingsButton extends StatelessWidget {
  const _RemoveStorageSettingsButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
      ),
      child: const Text("Remover armazém"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class _StorageList extends StatelessWidget {
  const _StorageList({
    required this.onTap,
    this.storageButtonStyle,
    Key? key,
  }) : super(key: key);

  final Function(String) onTap;
  final ButtonStyle? storageButtonStyle;

  @override
  Widget build(BuildContext context) {
    return Selector<StoragesMenuData, List<StorageButtonData>>(
      selector: (_, data) => data.storageButtonData,
      builder: (context, storageButtonData, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = storageButtonData[index];
            return _StorageButton(
              name: data.name,
              buttonStyle: storageButtonStyle,
              onTap: onTap,
            );
          },
          separatorBuilder: (_, __) {
            return const Divider();
          },
          itemCount: storageButtonData.length,
        );
      },
    );
  }
}

class _StorageButton extends StatelessWidget {
  const _StorageButton({
    Key? key,
    required this.name,
    this.buttonStyle,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final ButtonStyle? buttonStyle;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextButton(
          style: buttonStyle,
          child: Text(name),
          onPressed: () {
            onTap(name);
          }),
    );
  }
}

class _StorageMenuPopup extends StatelessWidget {
  const _StorageMenuPopup({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final StoragesMenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _AddStoragePopup(viewModel: viewModel),
        _RemoveStoragePopup(viewModel: viewModel),
      ],
    );
  }
}

class _AddStoragePopup extends StatelessWidget {
  _AddStoragePopup({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final StoragesMenuViewModel viewModel;
  final TextEditingController nameController = TextEditingController();

  Future<void> _confirmButtonTap() async {
    bool isCreated = await viewModel.createStorage(nameController.text);

    if (isCreated) {
      nameController.text = "";
      viewModel.hidePopup();
    }
  }

  void _cancelButtonTap() {
    nameController.text = "";
    viewModel.hidePopup();
  }

  @override
  Widget build(BuildContext context) {
    return Selector<StoragesMenuData, bool>(
      selector: (_, data) => data.showAddStoragePopup,
      builder: (context, showAddStoragePopup, _) => Visibility(
        visible: showAddStoragePopup,
        child: AlertDialog(
          title: const Text('Adicionar Armazém'),
          content: SizedBox(
            height: 130,
            child: Column(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Nome do Armazém',
                    ),
                  ),
                ),
                Row(
                  children: [
                    TextButton(
                      child: const Text('Confirmar'),
                      onPressed: _confirmButtonTap,
                    ),
                    TextButton(
                      child: const Text('Cancelar'),
                      onPressed: _cancelButtonTap,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RemoveStoragePopup extends StatelessWidget {
  _RemoveStoragePopup({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final StoragesMenuViewModel viewModel;
  final ValueNotifier<String> storageNameNotifier = ValueNotifier<String>("");

  Future<void> _confirmButtonTap() async {
    bool isRemoved = await viewModel.removeStorage(storageNameNotifier.value);

    if (isRemoved) {
      viewModel.hidePopup();
      resetParameters();
    }
  }

  void _cancelButtonTap() {
    viewModel.hidePopup();
    resetParameters();
  }

  void _selectedStorage(String name) {
    storageNameNotifier.value = name;
  }

  void resetParameters() {
    storageNameNotifier.value = "";
  }

  Widget _removeLabelName() {
    return AnimatedBuilder(
      animation: storageNameNotifier,
      builder: (BuildContext context, Widget? child) {
        return Text(
          "Remover armazém - " "${storageNameNotifier.value}",
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.blue),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Selector<StoragesMenuData, bool>(
      selector: (_, data) => data.showRemoveStoragePopup,
      builder: (context, showRemoveStoragePopup, _) => Visibility(
        visible: showRemoveStoragePopup,
        child: AlertDialog(
          title: const Text('Remover Armazém'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 300.0,
                  width: 300.0,
                  child: _StorageList(
                    onTap: _selectedStorage,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _removeLabelName(),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Confirmar'),
              onPressed: _confirmButtonTap,
            ),
            TextButton(
              child: const Text('Cancelar'),
              onPressed: _cancelButtonTap,
            ),
          ],
        ),
      ),
    );
  }
}
