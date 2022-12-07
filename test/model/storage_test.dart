import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/model/storage.dart';

void main() {
  Storage storage = const Storage(name: "norte", documentID: "29312");
  test('Storage created succesfully', () async {
    expect(storage.name, "norte");
    expect(storage.documentID, "29312");
  });

  test('Create a Storage through copy', () async {
    Storage newStorage = storage.copyWith(name: "sul");

    expect(newStorage.name, "sul");
    expect(newStorage.documentID, "29312");
  });

  test('Copy an Item from a JSON', () async {
    Map<String, Object> json = {
      'name': "norte",
      'documentID': "29312",
    };

    Storage newStorage = Storage.fromJson(json);

    expect(newStorage.name, "norte");
    expect(newStorage.documentID, "29312");
  });

  test('Pass the Item to a JSON', () async {
    storage.toJson();

    Map<String, Object> jsonExpected = {
      'name': storage.name,
      'documentID': storage.documentID,
    };

    expect(storage.toJson(), jsonExpected);
  });
}
