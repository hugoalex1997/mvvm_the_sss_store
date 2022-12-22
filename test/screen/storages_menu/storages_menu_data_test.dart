import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/model/storage.dart';

void main() {
  test('initial method is returning the correct data', () {
    StoragesMenuData storagesMenuData = const StoragesMenuData(
        storagesData: [],
        showEmptyState: false,
        showLoading: false,
        createStoragePopup: PopupData.initial(),
        removeStoragePopup: PopupData.initial());

    StoragesMenuData initialData = const StoragesMenuData.initial();

    expect(initialData, storagesMenuData);
  });

  test('Storage Button Data is correctly created from a Storage Class instance',
      () {
    StorageData storagesData = const StorageData(name: "norte");
    Storage storage1 = const Storage(name: "norte", documentID: "4435");
    Storage storage2 = const Storage(name: "sul", documentID: "4435");
    StorageData newStorageButtonData1 = StorageData.fromStorage(storage1);
    StorageData newStorageButtonData2 = StorageData.fromStorage(storage2);

    expect(storagesData, newStorageButtonData1);
    expect(storagesData != newStorageButtonData2, true);
  });
}
