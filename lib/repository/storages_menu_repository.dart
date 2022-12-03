import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:the_sss_store/model/storage.dart';
import 'package:the_sss_store/services/firebase/firebase_storages_menu_api.dart';

@singleton
class StoragesMenuRepository {
  StoragesMenuRepository(this._storagesMenuFirebase);

  final FirebaseStoragesMenuAPI _storagesMenuFirebase;
  
  List<Storage> _storageList = [];
  final _storageListSC = StreamController<List<Storage>>.broadcast();

  Stream<List<Storage>> observeStorageList() async* {
    yield _storageList;
    yield* _storageListSC.stream;
  }

  Future<void> fetchStorageList() async  {
    _storageList = await _storagesMenuFirebase.getStoragesList();
    _storageListSC.add(_storageList);

  }

  void createStorage(String name) {
    _storagesMenuFirebase.createStorage(name);
    fetchStorageList();
  }

  void removeStorage(String name) async {
    await _storagesMenuFirebase.removeStorage(name);
    fetchStorageList();
  }

  
}
