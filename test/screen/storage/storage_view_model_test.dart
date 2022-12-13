import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/repository/storage_repository.dart';
import 'package:the_sss_store/screen/storage/storage_view_model.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/model/item.dart';
import 'package:the_sss_store/screen/storage/storage_data.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

import 'storage_view_model_test.mocks.dart';

@GenerateMocks([StorageRepository])
void main() {
  initializeGetIt();
  MockStorageRepository storageRepository = MockStorageRepository();
  StorageViewModel storageViewModel = StorageViewModel(storageRepository);

  List<Item> itemListForTests = [
    const Item(
        name: "item1", available: 30, stock: 30, documentID: "document1"),
    const Item(
        name: "item2", available: 10, stock: 30, documentID: "document2"),
    const Item(name: "item3", available: 5, stock: 5, documentID: "document3"),
  ];

  setUp(() {
    storageRepository = MockStorageRepository();
    storageViewModel = StorageViewModel(storageRepository);

    when(storageRepository.observeItemList()).thenAnswer((_) {
      return Stream.value(itemListForTests);
    });
  });

  group('Test Storage View Model', () {
    String storageName = "storage_test";
    String documentID = "documentID_test";
    test('Storage View Model constructor', () async {
      expect(storageViewModel.value, const StorageData.initial());
    });
    test('Init fetching an empty list', () async {
      when(storageRepository.observeItemList()).thenAnswer((_) {
        return Stream.value([]);
      });
      await storageViewModel.init(documentID, storageName);

      expect(storageViewModel.value.itemData, []);
      expect(storageViewModel.value.showEmptyState, true);
      verify(storageRepository.fetchItemList(documentID)).called(1);
    });

    test('Init fetching a non empty list', () async {
      when(storageRepository.observeItemList()).thenAnswer((_) {
        return Stream.value(itemListForTests);
      });

      await storageViewModel.init(documentID, storageName);

      expect(
        storageViewModel.value.itemData,
        itemListForTests.map(ItemData.fromItem).toList(),
      );
      expect(storageViewModel.value.showEmptyState, false);
      verify(storageRepository.fetchItemList(documentID)).called(1);
    });

    test('Add item popup data is updated correctly', () async {
      await storageViewModel.init(documentID, storageName);

      expect(
          storageViewModel.value.showAddItemPopup, const PopupData.initial());

      storageViewModel.showAddItemPopup();

      expect(storageViewModel.value.showAddItemPopup, const PopupData.show());

      storageViewModel.hidePopup();

      expect(
          storageViewModel.value.showAddItemPopup, const PopupData.initial());
    });

    test('Remove item opup data is updated correctly', () async {
      await storageViewModel.init(documentID, storageName);

      expect(storageViewModel.value.showRemoveItemPopup,
          const PopupData.initial());

      storageViewModel.showRemoveItemPopup();

      expect(
          storageViewModel.value.showRemoveItemPopup, const PopupData.show());

      storageViewModel.hidePopup();

      expect(storageViewModel.value.showRemoveItemPopup,
          const PopupData.initial());
    });

    group('Create Item', () {
      test('Can create a Item', () async {
        String itemName = "cadeira";
        String stockString = "30";
        int stock = 30;

        await storageViewModel.init(documentID, storageName);

        storageViewModel.addItem(itemName, stockString);

        verify(storageViewModel
                .getStorageRepository()
                .addItem(documentID, itemName, stock))
            .called(1);
        expect(await storageViewModel.addItem(itemName, stockString), true);
      });

      test('Cant create a Item without a name', () async {
        String itemName = "";
        String stockString = "30";
        int stockValue = 30;

        await storageViewModel.init(documentID, storageName);

        storageViewModel.addItem(itemName, stockString);

        verifyNever(storageViewModel
            .getStorageRepository()
            .addItem(documentID, itemName, stockValue));
        expect(await storageViewModel.addItem(itemName, stockString), false);
      });

      test('Cant create an Item with stock 0', () async {
        String itemName = "mesa";
        String stockString = "0";
        int stockValue = 0;

        await storageViewModel.init(documentID, storageName);

        storageViewModel.addItem(itemName, stockString);

        verifyNever(storageViewModel
            .getStorageRepository()
            .addItem(documentID, itemName, stockValue));
        expect(await storageViewModel.addItem(itemName, stockString), false);
        expect(storageViewModel.value.showAddItemPopup,
            const PopupData.error("Stock Total deve ser superior a 0!"));
      });

      test('Cant create an Item when stock value is not a number', () async {
        String itemName = "mesa";
        String stockString = "s";

        await storageViewModel.init(documentID, storageName);

        storageViewModel.addItem(itemName, stockString);

        expect(await storageViewModel.addItem(itemName, stockString), false);
        expect(storageViewModel.value.showAddItemPopup,
            const PopupData.error("Stock Total é um número inválido!"));
      });
    });

    group('Remove Item', () {
      test('Can remove an Item', () async {
        String itemName = "cadeira";

        await storageViewModel.init(documentID, storageName);

        storageViewModel.removeItem(itemName);

        verify(storageViewModel
                .getStorageRepository()
                .removeItem(documentID, itemName))
            .called(1);
        expect(await storageViewModel.removeItem(storageName), true);
      });

      test('Cant remove a Item without a name', () async {
        String itemName = "";

        await storageViewModel.init(documentID, storageName);

        storageViewModel.removeItem(itemName);

        verifyNever(storageViewModel
            .getStorageRepository()
            .removeItem(documentID, itemName));

        expect(await storageViewModel.removeItem(itemName), false);
        expect(storageViewModel.value.showRemoveItemPopup,
            const PopupData.error("Nenhum item selecionado"));
      });
    });
  });
}
