import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/model/item.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';

void main() {
  test('initial method is returning the correct data', () {
    StorageData storageData = const StorageData(
        name: "",
        itemData: [],
        showEmptyState: false,
        showLoading: false,
        addItemPopup: PopupData.initial(),
        removeItemPopup: PopupData.initial());

    StorageData initialData = const StorageData.initial();

    expect(initialData, storageData);
  });

  test('Item Data is correctly created from a Item Class instance', () {
    ItemData itemData = const ItemData(name: "mesa", available: 25, stock: 30);
    Item item1 =
        const Item(name: "mesa", available: 25, stock: 30, documentID: "4435");
    Item item2 =
        const Item(name: "mesa", available: 24, stock: 25, documentID: "4435");
    ItemData newItemData1 = ItemData.fromItem(item1);
    ItemData newItemData2 = ItemData.fromItem(item2);

    expect(itemData, newItemData1);
    expect(itemData != newItemData2, true);
  });
}
