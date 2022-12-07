import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/model/item.dart';

void main() {
  Item item =
      const Item(name: "mesa", documentID: "12392", available: 3, stock: 4);
  test('Item created succesfully', ()  {
    expect(item.name, "mesa");
    expect(item.documentID, "12392");
    expect(item.available, 3);
    expect(item.stock, 4);
  });

  test('Create an Item through copy', ()  {
    Item newItem = item.copyWith(name: "cadeira", available: 0);

    expect(newItem.name, "cadeira");
    expect(newItem.documentID, "12392");
    expect(newItem.available, 0);
    expect(newItem.stock, 4);
  });

  test('Copy an Item from a JSON', ()  {
    Map<String, Object> json = {
      'name': "mesa",
      'documentID': "12392",
      'available': 3,
      'stock': 4,
    };

    Item newItem = Item.fromJson(json);

    expect(newItem.name, "mesa");
    expect(newItem.documentID, "12392");
    expect(newItem.available, 3);
    expect(newItem.stock, 4);
  });

  test('Pass the Item to a JSON', ()  {
    item.toJson();

    Map<String, Object> jsonExpected = {
      'name': item.name,
      'documentID': item.documentID,
      'available': item.available,
      'stock': item.stock,
    };

    expect(item.toJson(), jsonExpected);
  });
}
