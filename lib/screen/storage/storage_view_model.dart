import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';
import 'package:the_sss_store/repository/storage_repository.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

@injectable
class StorageViewModel extends ViewModel<StorageData> {
  StorageViewModel(this._storageRepository)
      : super(const StorageData.initial());

  final StorageRepository _storageRepository;

  StreamSubscription<List<ItemData>>? _storageSub;
  String documentID = "";
  String storageName = "";

  @visibleForTesting
  StorageRepository getStorageRepository() {
    return _storageRepository;
  }

  Future<void> init(String documentID, String storageName) async {
    this.documentID = documentID;
    this.storageName = storageName;

    _storageSub = _storageRepository
        .observeItemList()
        .map((storageList) => storageList.map(ItemData.fromItem).toList())
        .listen(_onStockChanged);

    await _updateList();
  }

  @override
  void dispose() {
    _storageSub?.cancel();
    super.dispose();
  }

  void _updateState({
    List<ItemData>? item,
    bool? isLoading,
    PopupData? showAddItemPopup,
    PopupData? showRemoveItemPopup,
  }) {
    item ??= value.itemData;
    isLoading ??= value.showLoading;
    showAddItemPopup ??= value.showAddItemPopup;
    showRemoveItemPopup ??= value.showRemoveItemPopup;

    stateData = StorageData(
      name: storageName,
      itemData: item,
      showEmptyState: item.isEmpty && !isLoading,
      showLoading: isLoading,
      showAddItemPopup: showAddItemPopup,
      showRemoveItemPopup: showRemoveItemPopup,
    );
  }

  Future<void> _updateList() async {
    _updateState(isLoading: true);

    await _storageRepository.fetchItemList(documentID);

    _updateState(isLoading: false);
  }

  void _onStockChanged(List<ItemData> item) {
    _updateState(item: item);
  }

  void showAddItemPopup() {
    _updateState(showAddItemPopup: const PopupData.show());
  }

  void showRemoveItemPopup() {
    _updateState(showRemoveItemPopup: const PopupData.show());
  }

  void hidePopup() {
    _updateState(
        showAddItemPopup: const PopupData.initial(),
        showRemoveItemPopup: const PopupData.initial());
  }

  Future<bool> addItem(String name, String stock) async {
    if (name.isEmpty) {
      _updateState(
          showAddItemPopup: const PopupData.error("Deve inserir um nome!"));
      return false;
    }

    int stockValue = 0;
    try {
      stockValue = int.parse(stock);
    } catch (error) {
      _updateState(
          showAddItemPopup:
              const PopupData.error("Stock Total é um número inválido!"));
      return false;
    }

    if (stockValue <= 0) {
      _updateState(
          showAddItemPopup:
              const PopupData.error("Stock Total deve ser superior a 0!"));
      return false;
    }

    _storageRepository.addItem(documentID, name, stockValue);
    return true;
  }

  Future<bool> removeItem(String name) async {
    if (name.isEmpty) {
      //TODO: When an item is chosen, this error must be removed.
      _updateState(
          showRemoveItemPopup:
              const PopupData.error("Nenhum item selecionado"));
      return false;
    }

    _storageRepository.removeItem(documentID, name);
    return true;
  }
}
