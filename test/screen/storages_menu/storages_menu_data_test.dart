import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/model/storage.dart';

void main() {
  test('initial method is returning the correct data', () {
    StoragesMenuData storagesMenuData = const StoragesMenuData(
        storageButtonData: [],
        showEmptyState: false,
        showLoading: false,
        showCreateStoragePopup: PopupData.initial(),
        showRemoveStoragePopup: PopupData.initial());

    StoragesMenuData initialData = const StoragesMenuData.initial();

    expect(initialData, storagesMenuData);
  });

  test('Storage Button Data is correctly created from a Storage Class instance',
      () {
    StorageButtonData storageButtonData =
        const StorageButtonData(name: "norte");
    Storage storage1 = const Storage(name: "norte", documentID: "4435");
    Storage storage2 = const Storage(name: "sul", documentID: "4435");
    StorageButtonData newStorageButtonData1 =
        StorageButtonData.fromStorage(storage1);
    StorageButtonData newStorageButtonData2 =
        StorageButtonData.fromStorage(storage2);

    expect(storageButtonData, newStorageButtonData1);
    expect(storageButtonData != newStorageButtonData2, true);
  });
}
