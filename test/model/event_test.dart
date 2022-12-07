import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/model/event.dart';

void main() {
  Event event = const Event(name: "queima", documentID: "2015");
  test('Event created succesfully', () async {
    expect(event.name, "queima");
    expect(event.documentID, "2015");
  });

  test('Create a Event through copy', () async {
    Event newEvent = event.copyWith(name: "latada");

    expect(newEvent.name, "latada");
    expect(newEvent.documentID, "2015");
  });

  test('Copy an Item from a JSON', () async {
    Map<String, Object> json = {
      'name': "queima",
      'documentID': "2015",
    };

    Event newEvent = Event.fromJson(json);

    expect(newEvent.name, "queima");
    expect(newEvent.documentID, "2015");
  });

  test('Pass the Item to a JSON', () async {
    event.toJson();

    Map<String, Object> jsonExpected = {
      'name': event.name,
      'documentID': event.documentID,
    };

    expect(event.toJson(), jsonExpected);
  });
}
