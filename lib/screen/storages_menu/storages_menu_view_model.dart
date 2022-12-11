import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';
import 'package:the_sss_store/repository/storages_menu_repository.dart';

@injectable
class StoragesMenuViewModel extends ViewModel<StoragesMenuData> {
  StoragesMenuViewModel(this._storagesMenuRepository)
      : super(const StoragesMenuData.initial());

  final StoragesMenuRepository _storagesMenuRepository;

  StreamSubscription<List<StorageButtonData>>? _storagesSub;

  @visibleForTesting
  StoragesMenuRepository getStoragesMenuRepository() {
    return _storagesMenuRepository;
  }

  Future<void> init() async {
    _storagesSub = _storagesMenuRepository
        .observeStorageList()
        .map((storageList) =>
            storageList.map(StorageButtonData.fromStorage).toList())
        .listen(_onStorageChanged);

    await _updateList();
  }

  @override
  void dispose() {
    _storagesSub?.cancel();
    super.dispose();
  }

  void _updateState({
    List<StorageButtonData>? button,
    bool? isLoading,
    bool? showCreateStoragePopup,
    bool? showRemoveStoragePopup,
  }) {
    button ??= value.storageButtonData;
    isLoading ??= value.showLoading;
    showCreateStoragePopup ??= value.showCreateStoragePopup;
    showRemoveStoragePopup ??= value.showRemoveStoragePopup;

    stateData = StoragesMenuData(
      storageButtonData: button,
      showEmptyState: button.isEmpty && !isLoading,
      showLoading: isLoading,
      showCreateStoragePopup: showCreateStoragePopup,
      showRemoveStoragePopup: showRemoveStoragePopup,
    );
  }

  Future<void> _updateList() async {
    _updateState(isLoading: true);

    await _storagesMenuRepository.fetchStorageList();

    _updateState(isLoading: false);
  }

  void _onStorageChanged(List<StorageButtonData> button) {
    _updateState(button: button);
  }

  void showCreateStoragePopup() {
    _updateState(showCreateStoragePopup: true);
  }

  void showRemoveStoragePopup() {
    _updateState(showRemoveStoragePopup: true);
  }

  void hidePopup() {
    _updateState(showCreateStoragePopup: false, showRemoveStoragePopup: false);
  }

  Future<bool> createStorage(String name) async {
    if (name.isEmpty) {
      return false;
    }

    _storagesMenuRepository.createStorage(name);
    return true;
  }

  Future<bool> removeStorage(String name) async {
    if (name.isEmpty) {
      return false;
    }

    _storagesMenuRepository.removeStorage(name);
    return true;
  }

  Future<String> getStorageDocumentID(String name) async {
    return await _storagesMenuRepository.getStorageDocumentID(name);
  }
}
