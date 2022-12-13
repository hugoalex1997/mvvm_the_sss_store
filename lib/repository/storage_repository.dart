import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/model/item.dart';
import 'package:the_sss_store/services/firebase/firebase_storage_api.dart';

@singleton
class StorageRepository {
  StorageRepository(this._storageFirebase);

  final FirebaseStorageAPI _storageFirebase;

  List<Item> _itemList = [];
  final _itemListSC = StreamController<List<Item>>.broadcast();

  @visibleForTesting
  List<Item> getItemList() {
    return _itemList;
  }

  Stream<List<Item>> observeItemList() async* {
    yield _itemList;
    yield* _itemListSC.stream;
  }

  Future<void> fetchItemList(String documentID) async {
    _itemList = await _storageFirebase.getItemList(documentID);
    _itemListSC.add(_itemList);
  }

  void addItem(String documentID, String name, int stock) {
    _storageFirebase.addItem(documentID, name, stock);
    fetchItemList(documentID);
  }

  void removeItem(String documentID, String name) async {
    await _storageFirebase.removeItem(documentID, name);
    fetchItemList(documentID);
  }
}
