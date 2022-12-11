import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:the_sss_store/model/item.dart';

@singleton
class FirebaseStorageAPI {
  final String storagesCollectionName = "storages";
  final String stockCollectionName = "stock";

  CollectionReference _getStoragesCollection() {
    return FirebaseFirestore.instance.collection(storagesCollectionName);
  }

  DocumentReference getStorageDocument(String documentID) {
    return _getStoragesCollection().doc(documentID);
  }

  CollectionReference getStockCollection(String documentID) {
    return getStorageDocument(documentID).collection(stockCollectionName);
  }

  Future<List<Item>> getItemList(String documentID) async {
    CollectionReference stockCollection = getStockCollection(documentID);

    QuerySnapshot stockSnapshot = await stockCollection.get();

    Iterable<Item> storagesDocumentsData =
        stockSnapshot.docs.map((doc) => Item.fromJson(doc.data() as Map<String, dynamic>));

    List<Item> storageList = [];
    for (final storage in storagesDocumentsData) {
      storageList.add(storage);
    }

    return storageList;
  }

  Future<String?> getItemDocumentID(String storageDocument, String name) async {
    CollectionReference stockCollection = getStockCollection(storageDocument);

    QuerySnapshot stockCollectionSnapshot = await stockCollection.get();
    Iterable<Item> storagesDocumentsData =
        stockCollectionSnapshot.docs.map((doc) => Item.fromJson(doc.data() as Map<String, dynamic>));

    for (int index = 0; index < storagesDocumentsData.length; index++) {
      String itemName = storagesDocumentsData.elementAt(index).name;
      if (itemName == name) {
        String documentID = storagesDocumentsData.elementAt(index).documentID;
        return documentID;
      }
    }
    return null;
  }

  void addItem(String documentID, String itemName, int stock) {
    CollectionReference stockCollection = getStockCollection(documentID);

    DocumentReference newItemDocument = stockCollection.doc();
    newItemDocument.set(Item(name: itemName, documentID: newItemDocument.id, available: stock, stock: stock).toJson());
  }

  Future<void> removeItem(String documentID, String name) async {
    CollectionReference stockCollection = getStockCollection(
      documentID,
    );

    QuerySnapshot stockCollectionSnapshot = await stockCollection.get();
    Iterable<Item> itemDocumentsData =
        stockCollectionSnapshot.docs.map((doc) => Item.fromJson(doc.data() as Map<String, dynamic>));

    for (int index = 0; index < itemDocumentsData.length; index++) {
      String itemName = itemDocumentsData.elementAt(index).name;
      if (itemName == name) {
        String documentID = itemDocumentsData.elementAt(index).documentID;
        stockCollection.doc(documentID).delete();
        return;
      }
    }
  }

  Future<bool> itemFound(String storageDocument, String name) async {
    String? documentID = await getItemDocumentID(storageDocument, name);

    return documentID == null ? false : true;
  }
}
