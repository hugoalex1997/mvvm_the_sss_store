import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/repository/storages_menu_repository.dart';
import 'package:the_sss_store/services/firebase/firebase_storages_menu_api.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/model/storage.dart';

import '../storages_menu_repository_test.mocks.dart';

@GenerateMocks([FirebaseStoragesMenuAPI])
void main() {
  initializeGetIt();

  void getStorageListReturns3Storages(MockFirebaseStoragesMenuAPI db) {
    when(db.getStoragesList()).thenAnswer((_) async => [
          const Storage(name: "storage1", documentID: "document1"),
          const Storage(name: "storage2", documentID: "document2"),
          const Storage(name: "storage3", documentID: "document3"),
        ]);
  }

  void getStorageListReturnsNothing(MockFirebaseStoragesMenuAPI db) {
    when(db.getStoragesList()).thenAnswer((_) async => []);
  }

  group(
    'Test Storages Menu Repository',
    () {
      test('Storage Menu Repository construction', () async {
        final dbMock = MockFirebaseStoragesMenuAPI();
        final storagesMenuRepo = StoragesMenuRepository(dbMock);

        expect(storagesMenuRepo.getStorageList(), []);
      });

      test('Fetch an empty list', () async {
        final dbMock = MockFirebaseStoragesMenuAPI();
        final storagesMenuRepo = StoragesMenuRepository(dbMock);
        getStorageListReturnsNothing(dbMock);

        await storagesMenuRepo.fetchStorageList();

        expect(storagesMenuRepo.getStorageList(), []);
        verify(dbMock.getStoragesList()).called(1);
      });

      test('Fetch a list with 3 storages', () async {
        final dbMock = MockFirebaseStoragesMenuAPI();
        final storagesMenuRepo = StoragesMenuRepository(dbMock);
        getStorageListReturns3Storages(dbMock);

        await storagesMenuRepo.fetchStorageList();

        expect(storagesMenuRepo.getStorageList(), [
          const Storage(name: "storage1", documentID: "document1"),
          const Storage(name: "storage2", documentID: "document2"),
          const Storage(name: "storage3", documentID: "document3"),
        ]);
      });

      test('When List is fetched storage list stream is updated', () async {
        final dbMock = MockFirebaseStoragesMenuAPI();
        final storagesMenuRepo = StoragesMenuRepository(dbMock);
        getStorageListReturns3Storages(dbMock);

        expect(storagesMenuRepo.observeStorageList(), emits([]));

        await storagesMenuRepo.fetchStorageList();

        expect(
            storagesMenuRepo.observeStorageList(),
            emits([
              const Storage(name: "storage1", documentID: "document1"),
              const Storage(name: "storage2", documentID: "document2"),
              const Storage(name: "storage3", documentID: "document3"),
            ]));
      });
    },
  );
}
