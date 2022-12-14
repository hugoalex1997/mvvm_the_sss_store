import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/model/event.dart';

void main() {
  DateTime testDate = DateTime.now();
  DateTime testDate2 = DateTime.now();

  Event event = Event(
      name: "queima",
      documentID: "2015",
      startDate: testDate,
      endDate: testDate2);
  test('Event created succesfully', () {
    expect(event.name, "queima");
    expect(event.documentID, "2015");
    expect(event.startDate, testDate);
    expect(event.endDate, testDate2);
  });

  test('Create a Event through copy', () {
    DateTime testDate = DateTime.now();
    Event newEvent =
        event.copyWith(name: "Latada", startDate: testDate, endDate: testDate2);

    expect(newEvent.name, "Latada");
    expect(newEvent.documentID, "2015");
    expect(newEvent.startDate, testDate);
    expect(newEvent.endDate, testDate2);
  });

  test('Copy an Item from a JSON', () {
    Timestamp timestamp = Timestamp.now();
    Timestamp timestamp2 = Timestamp.now();

    Map<String, Object> json = {
      'name': "queima",
      'documentID': "2015",
      'startDate': timestamp,
      'endDate': timestamp2
    };

    Event newEvent = Event.fromJson(json);

    expect(newEvent.name, "queima");
    expect(newEvent.documentID, "2015");
    expect(newEvent.startDate, timestamp.toDate());
    expect(newEvent.endDate, timestamp2.toDate());
  });

  test('Pass the Item to a JSON', () {
    event.toJson();

    Map<String, Object> jsonExpected = {
      'name': event.name,
      'documentID': event.documentID,
      'startDate': testDate,
      'endDate': testDate2,
    };

    expect(event.toJson(), jsonExpected);
  });
}
