import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/view_model/view_model.dart';
import 'package:the_sss_store/repository/storages_menu_repository.dart';

@injectable
class StoragesMenuViewModel extends ViewModel<StoragesMenuData> {
  StoragesMenuViewModel(this._storagesMenuRepository) : super(const StoragesMenuData.initial());

  final StoragesMenuRepository _storagesMenuRepository;

  StreamSubscription<List<StorageButtonData>>? _storagesSub;

  void init() {
    _updateList();

    _storagesSub = _storagesMenuRepository
        .observeStorageList()
        .map((storageList) => storageList.map(StorageButtonData.fromStorage).toList())
        .listen(_onStorageChanged);
  }

  @override
  void dispose() {
    _storagesSub?.cancel();
    super.dispose();
  }

  void _updateState({
    List<StorageButtonData>? button,
    bool? isLoading,
    bool? showAddStoragePopup,
    bool? showRemoveStoragePopup,
  }) {
    button ??= value.storageButtonData;
    isLoading ??= value.showLoading;
    showAddStoragePopup ??= value.showAddStoragePopup;
    showRemoveStoragePopup ??= value.showRemoveStoragePopup;

    stateData = StoragesMenuData(
      storageButtonData: button,
      showEmptyState: button.isEmpty && !isLoading,
      showLoading: isLoading,
      showAddStoragePopup: showAddStoragePopup,
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

  void showAddStoragePopup() {
    _updateState(showAddStoragePopup: true);
    

  }

  void showRemoveStoragePopup() {
    _updateState(showRemoveStoragePopup: true);
  }

  void hidePopup() {
    _updateState(showAddStoragePopup: false, showRemoveStoragePopup: false );
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
  
}
