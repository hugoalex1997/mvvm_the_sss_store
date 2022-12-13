import 'package:flutter/material.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';
import 'package:provider/provider.dart';
import 'package:the_sss_store/screen/storage/storage_screen.dart';
import 'package:the_sss_store/common/widgets/error_popup_label.dart';

//TODO: Analyze the possibility of removing duplicate code between the storage menu and the event menu
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
        actions: [
          SettingsButton(viewModel: viewModel),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          StorageList(
            onTap: _onStorageButtonTap,
            storageButtonStyle: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
            ),
          ),
          const Center(child: ProgressBar()),
          const EmptyState(),
          StoragesMenuPopups(viewModel: viewModel),
        ],
      ),
    );
  }

  void _onStorageButtonTap(String name) async {
    String documentID = await viewModel.getStorageDocumentID(name);
    StorageScreenRoute()
        .push(context, {"documentID": documentID, "name": name});
  }
}

class ProgressBar extends StatelessWidget {
  @visibleForTesting
  const ProgressBar({Key? key}) : super(key: key);

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

class EmptyState extends StatelessWidget {
  @visibleForTesting
  const EmptyState({Key? key}) : super(key: key);

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

class SettingsButton extends StatelessWidget {
  @visibleForTesting
  const SettingsButton({required this.viewModel, Key? key}) : super(key: key);

  final StoragesMenuViewModel viewModel;

  void _onCreateStorageButtonTap() {
    viewModel.showCreateStoragePopup();
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
            child: CreateStorageSettingsButton(onTap: () {
              _onCreateStorageButtonTap();
              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: RemoveStorageSettingsButton(onTap: () {
              _onRemoveStorageButtonTap();
              Navigator.pop(context);
            }),
          ),
        ];
      },
    );
  }
}

class CreateStorageSettingsButton extends StatelessWidget {
  @visibleForTesting
  const CreateStorageSettingsButton({
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
      child: const Text("Criar armazém"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class RemoveStorageSettingsButton extends StatelessWidget {
  @visibleForTesting
  const RemoveStorageSettingsButton({
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

class StorageList extends StatelessWidget {
  @visibleForTesting
  const StorageList({
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
            return StorageButton(
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

class StorageButton extends StatelessWidget {
  @visibleForTesting
  const StorageButton({
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

class StoragesMenuPopups extends StatelessWidget {
  @visibleForTesting
  const StoragesMenuPopups({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final StoragesMenuViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CreateStoragePopup(viewModel: viewModel),
        RemoveStoragePopup(viewModel: viewModel),
      ],
    );
  }
}

class CreateStoragePopup extends StatelessWidget {
  @visibleForTesting
  CreateStoragePopup({
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
    return Selector<StoragesMenuData, PopupData>(
      selector: (_, data) => data.showCreateStoragePopup,
      builder: (context, showCreateStoragePopup, _) => Visibility(
        visible: showCreateStoragePopup.visible,
        child: AlertDialog(
          title: const Text('Adicionar Armazém'),
          content: SingleChildScrollView(
            child: SizedBox(
              height: 150,
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
                  ErrorPopupLabel(errorText: showCreateStoragePopup.error),
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
      ),
    );
  }
}

class RemoveStoragePopup extends StatelessWidget {
  @visibleForTesting
  RemoveStoragePopup({
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
    return Selector<StoragesMenuData, PopupData>(
      selector: (_, data) => data.showRemoveStoragePopup,
      builder: (context, showRemoveStoragePopup, _) => Visibility(
        visible: showRemoveStoragePopup.visible,
        child: AlertDialog(
          title: const Text('Remover Armazém'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 300.0,
                  width: 300.0,
                  child: StorageList(
                    onTap: _selectedStorage,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                _removeLabelName(),
                const SizedBox(height: 10),
                ErrorPopupLabel(errorText: showRemoveStoragePopup.error),
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
