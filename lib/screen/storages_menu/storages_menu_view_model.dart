import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';
import 'package:the_sss_store/repository/storages_menu_repository.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

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
    PopupData? createStoragePopup,
    PopupData? removeStoragePopup,
  }) {
    button ??= value.storageButtonData;
    isLoading ??= value.showLoading;
    createStoragePopup ??= value.createStoragePopup;
    removeStoragePopup ??= value.removeStoragePopup;

    stateData = StoragesMenuData(
      storageButtonData: button,
      showEmptyState: button.isEmpty && !isLoading,
      showLoading: isLoading,
      createStoragePopup: createStoragePopup,
      removeStoragePopup: removeStoragePopup,
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
    _updateState(createStoragePopup: const PopupData.show());
  }

  void showRemoveStoragePopup() {
    _updateState(removeStoragePopup: const PopupData.show());
  }

  void hidePopup() {
    _updateState(
        createStoragePopup: const PopupData.initial(),
        removeStoragePopup: const PopupData.initial());
  }

  Future<bool> createStorage(String name) async {
    if (name.isEmpty) {
      _updateState(
          createStoragePopup: const PopupData.error("Deve inserir um nome!"));
      return false;
    }

    _storagesMenuRepository.createStorage(name);
    return true;
  }

  Future<bool> removeStorage(String name) async {
    if (name.isEmpty) {
      //TODO: When a storage is choose, this error should be removed.
      _updateState(
          removeStoragePopup:
              const PopupData.error("Nenhum armazém selecionado!"));
      return false;
    }

    _storagesMenuRepository.removeStorage(name);
    return true;
  }

  Future<String> getStorageDocumentID(String name) async {
    return await _storagesMenuRepository.getStorageDocumentID(name);
  }
}
