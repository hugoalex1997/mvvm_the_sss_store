import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:the_sss_store/model/storage.dart';

//TODO: Handle Error scenarios
@singleton
class FirebaseStoragesMenuAPI {
  final String storagesCollectionName = "storages";

  CollectionReference _getStoragesCollection() {
    return FirebaseFirestore.instance.collection(storagesCollectionName);
  }

  Future<List<Storage>> getStoragesList() async {
    CollectionReference storagesCollection = _getStoragesCollection();

    QuerySnapshot storagesSnapshot = await storagesCollection.get();

    Iterable<Storage> storagesDocumentsData = storagesSnapshot.docs
        .map((doc) => Storage.fromJson(doc.data() as Map<String, dynamic>));

    List<Storage> storageList = [];
    for (final storage in storagesDocumentsData) {
      storageList.add(storage);
    }

    return storageList;
  }

  Future<String?> getStorageDocumentID(String name) async {
    CollectionReference storagesCollection = _getStoragesCollection();

    QuerySnapshot storagesSnapshot = await storagesCollection.get();
    Iterable<Storage> storagesDocumentsData = storagesSnapshot.docs
        .map((doc) => Storage.fromJson(doc.data() as Map<String, dynamic>));

    for (int index = 0; index < storagesDocumentsData.length; index++) {
      String storageName = storagesDocumentsData.elementAt(index).name;
      if (storageName == name) {
        String documentID = storagesDocumentsData.elementAt(index).documentID;
        return documentID;
      }
    }
    return null;
  }

  Storage createStorage(String storageName) {
    CollectionReference storagesCollection = _getStoragesCollection();
    DocumentReference newStorageDocument = storagesCollection.doc();

    Storage storage =
        Storage(name: storageName, documentID: newStorageDocument.id);
    newStorageDocument.set(storage.toJson());
    return storage;
  }

  Future<void> removeStorage(String name) async {
    CollectionReference storagesCollection = _getStoragesCollection();

    QuerySnapshot storagesCollectionSnapshot = await storagesCollection.get();
    Iterable<Storage> storagesDocumentsData = storagesCollectionSnapshot.docs
        .map((doc) => Storage.fromJson(doc.data() as Map<String, dynamic>));

    for (int index = 0; index < storagesDocumentsData.length; index++) {
      String storageName = storagesDocumentsData.elementAt(index).name;
      if (storageName == name) {
        String documentID = storagesDocumentsData.elementAt(index).documentID;
        storagesCollection.doc(documentID).delete();
        return;
      }
    }
  }

  Future<bool> storageFound(String name) async {
    String? documentID = await getStorageDocumentID(name);

    return documentID == null ? false : true;
  }
}
