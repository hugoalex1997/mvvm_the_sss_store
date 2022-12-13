import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/repository/storage_repository.dart';
import 'package:the_sss_store/services/firebase/firebase_storage_api.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/model/item.dart';

import 'storage_repository_test.mocks.dart';

@GenerateMocks([FirebaseStorageAPI])
void main() {
  initializeGetIt();

  void getItemListReturns3Storages(
      MockFirebaseStorageAPI db, String documentID) {
    when(db.getItemList(any)).thenAnswer((_) async => []);

    when(db.getItemList(documentID)).thenAnswer((_) async => [
          const Item(
              name: "item1", available: 30, stock: 30, documentID: "document1"),
          const Item(
              name: "item2", available: 10, stock: 30, documentID: "document2"),
          const Item(
              name: "item3", available: 5, stock: 5, documentID: "document3"),
        ]);
  }

  void getItemListReturnsNothing(MockFirebaseStorageAPI db, String documentID) {
    when(db.getItemList(documentID)).thenAnswer((_) async => []);
  }

  group(
    'Test Storage Repository',
    () {
      test('Storage Repository construction', () async {
        final dbMock = MockFirebaseStorageAPI();
        final storageRepo = StorageRepository(dbMock);

        expect(storageRepo.getItemList(), []);
      });

      test('Fetch an empty list', () async {
        final dbMock = MockFirebaseStorageAPI();
        final storageRepo = StorageRepository(dbMock);
        const documentID = "stock_test";
        getItemListReturnsNothing(dbMock, documentID);

        await storageRepo.fetchItemList(documentID);

        expect(storageRepo.getItemList(), []);
        verify(dbMock.getItemList(documentID)).called(1);
      });

      test('Fetch a list with 3 items', () async {
        final dbMock = MockFirebaseStorageAPI();
        final storageRepo = StorageRepository(dbMock);
        const documentID = "stock_test";
        getItemListReturns3Storages(dbMock, documentID);

        await storageRepo.fetchItemList(documentID);

        expect(storageRepo.getItemList(), [
          const Item(
              name: "item1", available: 30, stock: 30, documentID: "document1"),
          const Item(
              name: "item2", available: 10, stock: 30, documentID: "document2"),
          const Item(
              name: "item3", available: 5, stock: 5, documentID: "document3"),
        ]);
      });

      test('Fetch wrong Stock returns an empty list', () async {
        final dbMock = MockFirebaseStorageAPI();
        final storageRepo = StorageRepository(dbMock);
        const documentID = "stock_test";
        getItemListReturns3Storages(dbMock, documentID);

        await storageRepo.fetchItemList("other_stock");

        expect(storageRepo.getItemList(), []);
      });

      test('When List is fetched item List stream is updated', () async {
        final dbMock = MockFirebaseStorageAPI();
        final storageRepo = StorageRepository(dbMock);
        const documentID = "stock_test";
        getItemListReturns3Storages(dbMock, documentID);

        expect(storageRepo.observeItemList(), emits([]));

        await storageRepo.fetchItemList(documentID);

        expect(
            storageRepo.observeItemList(),
            emits([
              const Item(
                  name: "item1",
                  available: 30,
                  stock: 30,
                  documentID: "document1"),
              const Item(
                  name: "item2",
                  available: 10,
                  stock: 30,
                  documentID: "document2"),
              const Item(
                  name: "item3",
                  available: 5,
                  stock: 5,
                  documentID: "document3"),
            ]));
      });
    },
  );
}
