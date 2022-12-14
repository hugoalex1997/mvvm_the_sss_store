import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:the_sss_store/navigation/app_route.dart';
import 'package:the_sss_store/navigation/routes.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';
import 'package:the_sss_store/screen/storage/storage_view_model.dart';
import 'package:the_sss_store/screen/screen.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/common/data/item_data.dart';
import 'package:the_sss_store/common/widgets/popup.dart';

class StorageScreenRoute extends AppRoute {
  StorageScreenRoute()
      : super(
            path: Routes.storage,
            builder: (context, state) {
              Map<String, String> params = state.extra as Map<String, String>;
              return StorageScreen(
                  documentID: params["documentID"]!,
                  name: params["name"]!,
                  key: state.pageKey);
            });
}

class StorageScreen extends Screen {
  const StorageScreen({required this.documentID, required this.name, Key? key})
      : super(key: key);

  final String documentID;
  final String name;

  @override
  _StorageScreenState createState() => _StorageScreenState();
}

class _StorageScreenState
    extends ScreenState<StorageScreen, StorageViewModel, StorageData> {
  @override
  void initState() {
    super.initState();
    viewModel.init(widget.documentID, widget.name);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget buildScreen(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Armazém ' '${widget.name}'),
        actions: [
          SettingsButton(viewModel: viewModel),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          ItemList(
            onTap: _onItemButtonTap,
            storageButtonStyle: TextButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.black,
            ),
          ),
          const Center(child: ProgressBar()),
          const EmptyState(),
          StoragePopups(viewModel: viewModel),
        ],
      ),
    );
  }

  //TODO: Add Item Button Logic
  void _onItemButtonTap(String name) async {}
}

class ProgressBar extends StatelessWidget {
  @visibleForTesting
  const ProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Selector<StorageData, bool>(
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
    return Selector<StorageData, bool>(
      selector: (_, data) => data.showEmptyState,
      builder: (context, showEmptyState, _) => Visibility(
        visible: showEmptyState,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Text(
            'Não foi possível carregar o stock do armazém',
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

  final StorageViewModel viewModel;

  void _onAddItemButtonTap() {
    viewModel.showAddItemPopup();
  }

  void _onRemoveItemButton() {
    viewModel.showRemoveItemPopup();
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: AddItemSettingsButton(onTap: () {
              _onAddItemButtonTap();
              Navigator.pop(context);
            }),
          ),
          PopupMenuItem(
            child: RemoveItemSettingsButton(onTap: () {
              _onRemoveItemButton();
              Navigator.pop(context);
            }),
          ),
        ];
      },
    );
  }
}

class AddItemSettingsButton extends StatelessWidget {
  @visibleForTesting
  const AddItemSettingsButton({
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
      child: const Text("Adicionar item"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class RemoveItemSettingsButton extends StatelessWidget {
  @visibleForTesting
  const RemoveItemSettingsButton({
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
      child: const Text("Remover item"),
      onPressed: () {
        onTap();
      },
    );
  }
}

class ItemList extends StatelessWidget {
  @visibleForTesting
  const ItemList({
    required this.onTap,
    this.storageButtonStyle,
    Key? key,
  }) : super(key: key);

  final Function(String) onTap;
  final ButtonStyle? storageButtonStyle;

  @override
  Widget build(BuildContext context) {
    return Selector<StorageData, List<ItemData>>(
      selector: (_, data) => data.itemData,
      builder: (context, itemData, _) {
        return ListView.separated(
          itemBuilder: (context, index) {
            final data = itemData[index];
            return ItemButton(
              name: data.name,
              available: data.available,
              stock: data.stock,
              buttonStyle: storageButtonStyle,
              onTap: onTap,
            );
          },
          separatorBuilder: (_, __) {
            return const Divider();
          },
          itemCount: itemData.length,
        );
      },
    );
  }
}

class ItemButton extends StatelessWidget {
  @visibleForTesting
  const ItemButton({
    Key? key,
    required this.name,
    required this.available,
    required this.stock,
    this.buttonStyle,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final int available;
  final int stock;

  final ButtonStyle? buttonStyle;
  final Function(String) onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: TextButton(
          style: buttonStyle,
          child: Text("$name"
              " - "
              "Available: "
              "$available"
              " | "
              " Stock: "
              "$stock"),
          onPressed: () {
            onTap(name);
          }),
    );
  }
}

class StoragePopups extends StatelessWidget {
  @visibleForTesting
  const StoragePopups({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final StorageViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AddItemPopup(viewModel: viewModel),
        RemoveItemPopup(viewModel: viewModel),
      ],
    );
  }
}

class AddItemPopup extends StatelessWidget {
  @visibleForTesting
  AddItemPopup({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final StorageViewModel viewModel;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  Future<void> _confirmButtonTap() async {
    bool isCreated =
        await viewModel.addItem(nameController.text, stockController.text);

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
    return Selector<StorageData, PopupData>(
      selector: (_, data) => data.addItemPopup,
      builder: (context, addItemPopup, _) => Visibility(
        visible: addItemPopup.visible,
        child: Popup(
          title: 'Adicionar Item',
          confirmButtonTap: _confirmButtonTap,
          cancelButtonTap: _cancelButtonTap,
          bodyWidget: AddItemPopupBody(
            nameController: nameController,
            stockController: stockController,
          ),
          popupSize: 220,
          errorLabel: addItemPopup.error,
        ),
      ),
    );
  }
}

class AddItemPopupBody extends StatelessWidget {
  @visibleForTesting
  const AddItemPopupBody({
    required this.nameController,
    required this.stockController,
    Key? key,
  }) : super(key: key);

  final TextEditingController nameController;
  final TextEditingController stockController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Nome do Item',
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        TextField(
          controller: stockController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Stock Total',
          ),
        ),
      ],
    );
  }
}

class RemoveItemPopup extends StatelessWidget {
  @visibleForTesting
  RemoveItemPopup({
    Key? key,
    required this.viewModel,
  }) : super(key: key);

  final StorageViewModel viewModel;
  final ValueNotifier<String> itemNameNotifier = ValueNotifier<String>("");

  Future<void> _confirmButtonTap() async {
    bool isRemoved = await viewModel.removeItem(itemNameNotifier.value);

    if (isRemoved) {
      viewModel.hidePopup();
      resetParameters();
    }
  }

  void _cancelButtonTap() {
    viewModel.hidePopup();
    resetParameters();
  }

  void _selectedItem(String name) {
    itemNameNotifier.value = name;
  }

  void resetParameters() {
    itemNameNotifier.value = "";
  }

  @override
  Widget build(BuildContext context) {
    return Selector<StorageData, PopupData>(
      selector: (_, data) => data.removeItemPopup,
      builder: (context, removeItemPopup, _) => Visibility(
        visible: removeItemPopup.visible,
        child: Popup(
          title: 'Remover Item',
          confirmButtonTap: _confirmButtonTap,
          cancelButtonTap: _cancelButtonTap,
          bodyWidget: RemoveItemPopupBody(
            onItemTap: _selectedItem,
            itemNameNotifier: itemNameNotifier,
          ),
          popupSize: 420,
          errorLabel: removeItemPopup.error,
        ),
      ),
    );
  }
}

class RemoveItemPopupBody extends StatelessWidget {
  @visibleForTesting
  const RemoveItemPopupBody({
    required this.itemNameNotifier,
    required this.onItemTap,
    Key? key,
  }) : super(key: key);

  final ValueNotifier<String> itemNameNotifier;
  final Function(String) onItemTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300.0,
          width: 300.0,
          child: ItemList(
            onTap: onItemTap,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        AnimatedBuilder(
          animation: itemNameNotifier,
          builder: (BuildContext context, Widget? child) {
            return Text(
              "Remover item - " "${itemNameNotifier.value}",
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.blue),
            );
          },
        ),
      ],
    );
  }
}
