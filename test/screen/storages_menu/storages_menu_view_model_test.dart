import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/repository/storages_menu_repository.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_view_model.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/model/storage.dart';
import 'package:the_sss_store/screen/storages_menu/storages_menu_data.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

import './storages_menu_view_model_test.mocks.dart';

@GenerateMocks([StoragesMenuRepository])
void main() {
  initializeGetIt();
  MockStoragesMenuRepository storagesMenuRepository =
      MockStoragesMenuRepository();
  StoragesMenuViewModel storagesMenuViewModel =
      StoragesMenuViewModel(storagesMenuRepository);

  List<Storage> storageListForTests = [
    const Storage(name: "storage1", documentID: "document1"),
    const Storage(name: "storage2", documentID: "document2"),
    const Storage(name: "storage3", documentID: "document3"),
  ];

  setUp(() {
    storagesMenuRepository = MockStoragesMenuRepository();
    storagesMenuViewModel = StoragesMenuViewModel(storagesMenuRepository);

    when(storagesMenuRepository.observeStorageList()).thenAnswer((_) {
      return Stream.value(storageListForTests);
    });
  });

  group('Test Storages Menu View Model', () {
    test('Storages Menu View Model constructor', () async {
      expect(storagesMenuViewModel.value, const StoragesMenuData.initial());
    });
    test('Init fetching an empty list', () async {
      when(storagesMenuRepository.observeStorageList()).thenAnswer((_) {
        return Stream.value([]);
      });
      await storagesMenuViewModel.init();

      expect(storagesMenuViewModel.value.storagesData, []);
      expect(storagesMenuViewModel.value.showEmptyState, true);
      verify(storagesMenuRepository.fetchStorageList()).called(1);
    });

    test('Init fetching a non empty list', () async {
      when(storagesMenuRepository.observeStorageList()).thenAnswer((_) {
        return Stream.value(storageListForTests);
      });

      await storagesMenuViewModel.init();

      expect(
        storagesMenuViewModel.value.storagesData,
        storageListForTests.map(StorageData.fromStorage).toList(),
      );
      expect(storagesMenuViewModel.value.showEmptyState, false);
      verify(storagesMenuRepository.fetchStorageList()).called(1);
    });

    test('Create Storage Popup data is updated correctly', () async {
      await storagesMenuViewModel.init();

      expect(storagesMenuViewModel.value.createStoragePopup,
          const PopupData.initial());

      storagesMenuViewModel.showCreateStoragePopup();

      expect(storagesMenuViewModel.value.createStoragePopup,
          const PopupData.show());

      storagesMenuViewModel.hidePopup();

      expect(storagesMenuViewModel.value.createStoragePopup,
          const PopupData.initial());
    });

    test('Remove Storage Popup data is updated correctly', () async {
      await storagesMenuViewModel.init();

      expect(storagesMenuViewModel.value.removeStoragePopup,
          const PopupData.initial());

      storagesMenuViewModel.showRemoveStoragePopup();

      expect(storagesMenuViewModel.value.removeStoragePopup,
          const PopupData.show());

      storagesMenuViewModel.hidePopup();

      expect(storagesMenuViewModel.value.removeStoragePopup,
          const PopupData.initial());
    });

    group('Create Storage', () {
      test('Can create a Storage', () async {
        String storageName = "Lust";

        await storagesMenuViewModel.init();

        storagesMenuViewModel.createStorage(storageName);

        verify(storagesMenuViewModel
                .getStoragesMenuRepository()
                .createStorage(storageName))
            .called(1);
        expect(await storagesMenuViewModel.createStorage(storageName), true);
      });

      test('Cant create a Storage without a name', () async {
        String storageName = "";

        await storagesMenuViewModel.init();

        storagesMenuViewModel.createStorage(storageName);

        verifyNever(storagesMenuViewModel
            .getStoragesMenuRepository()
            .createStorage(storageName));
        expect(await storagesMenuViewModel.createStorage(storageName), false);
        expect(storagesMenuViewModel.value.createStoragePopup,
            const PopupData.error("Deve inserir um nome!"));
      });
    });

    group('Remove Storage ', () {
      test('Can remove a Storage', () async {
        String storageName = "Lust";

        await storagesMenuViewModel.init();

        storagesMenuViewModel.removeStorage(storageName);

        verify(storagesMenuViewModel
                .getStoragesMenuRepository()
                .removeStorage(storageName))
            .called(1);
        expect(await storagesMenuViewModel.removeStorage(storageName), true);
      });

      test('Cant remove a Storage without a name', () async {
        String storageName = "";

        await storagesMenuViewModel.init();

        storagesMenuViewModel.removeStorage(storageName);

        verifyNever(storagesMenuViewModel
            .getStoragesMenuRepository()
            .removeStorage(storageName));
        expect(await storagesMenuViewModel.removeStorage(storageName), false);
        expect(storagesMenuViewModel.value.removeStoragePopup,
            const PopupData.error("Nenhum armazém selecionado!"));
      });
    });
  });
}
