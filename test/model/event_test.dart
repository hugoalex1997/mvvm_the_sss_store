import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/model/event.dart';

void main() {
  Event event = const Event(name: "queima", documentID: "2015");
  test('Event created succesfully', ()  {
    expect(event.name, "queima");
    expect(event.documentID, "2015");
  });

  test('Create a Event through copy', ()  {
    Event newEvent = event.copyWith(name: "latada");

    expect(newEvent.name, "latada");
    expect(newEvent.documentID, "2015");
  });

  test('Copy an Item from a JSON', ()  {
    Map<String, Object> json = {
      'name': "queima",
      'documentID': "2015",
    };

    Event newEvent = Event.fromJson(json);

    expect(newEvent.name, "queima");
    expect(newEvent.documentID, "2015");
  });

  test('Pass the Item to a JSON', ()  {
    event.toJson();

    Map<String, Object> jsonExpected = {
      'name': event.name,
      'documentID': event.documentID,
    };

    expect(event.toJson(), jsonExpected);
  });
}
