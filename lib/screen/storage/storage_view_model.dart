import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';
import 'package:the_sss_store/repository/storage_repository.dart';

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
    bool? showAddItemPopup,
    bool? showRemoveItemPopup,
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
    _updateState(showAddItemPopup: true);
  }

  void showRemoveItemPopup() {
    _updateState(showRemoveItemPopup: true);
  }

  void hidePopup() {
    _updateState(showAddItemPopup: false, showRemoveItemPopup: false);
  }

  Future<bool> addItem(String name, int stock) async {
    if (name.isEmpty) {
      return false;
    }

    if (stock <= 0) {
      return false;
    }

    _storageRepository.addItem(documentID, name, stock);
    return true;
  }

  Future<bool> removeItem(String name) async {
    if (name.isEmpty) {
      return false;
    }

    _storageRepository.removeItem(documentID, name);
    return true;
  }
}
