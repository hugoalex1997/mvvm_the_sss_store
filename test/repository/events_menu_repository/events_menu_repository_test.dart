import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/repository/events_menu_repository.dart';
import 'package:the_sss_store/services/firebase/firebase_events_menu_api.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/model/event.dart';

import 'events_menu_repository_test.mocks.dart';

@GenerateMocks([FirebaseEventsMenuAPI])
void main() {
  initializeGetIt();
  DateTime testDate = DateTime.now();
  void getEventListReturns3Events(MockFirebaseEventsMenuAPI db) {
    when(db.getEventsList()).thenAnswer((_) async => [
          Event(
              name: "event1",
              documentID: "document1",
              startDate: testDate,
              endDate: testDate),
          Event(
              name: "event2",
              documentID: "document2",
              startDate: testDate,
              endDate: testDate),
          Event(
              name: "event3",
              documentID: "document3",
              startDate: testDate,
              endDate: testDate),
        ]);
  }

  void getEventListReturnsNothing(MockFirebaseEventsMenuAPI db) {
    when(db.getEventsList()).thenAnswer((_) async => []);
  }

  group(
    'Test Events Menu Repository',
    () {
      test('Event Menu Repository construction', () async {
        final dbMock = MockFirebaseEventsMenuAPI();
        final eventsMenuRepo = EventsMenuRepository(dbMock);

        expect(eventsMenuRepo.getEventList(), []);
      });

      test('Fetch an empty list', () async {
        final dbMock = MockFirebaseEventsMenuAPI();
        final eventsMenuRepo = EventsMenuRepository(dbMock);
        getEventListReturnsNothing(dbMock);

        await eventsMenuRepo.fetchEventList();

        expect(eventsMenuRepo.getEventList(), []);
        verify(dbMock.getEventsList()).called(1);
      });

      test('Fetch a list with 3 events', () async {
        final dbMock = MockFirebaseEventsMenuAPI();
        final eventsMenuRepo = EventsMenuRepository(dbMock);
        getEventListReturns3Events(dbMock);

        await eventsMenuRepo.fetchEventList();

        expect(eventsMenuRepo.getEventList(), [
          Event(
              name: "event1",
              documentID: "document1",
              startDate: testDate,
              endDate: testDate),
          Event(
              name: "event2",
              documentID: "document2",
              startDate: testDate,
              endDate: testDate),
          Event(
              name: "event3",
              documentID: "document3",
              startDate: testDate,
              endDate: testDate),
        ]);
      });

      test('When List is fetched event list stream is updated', () async {
        final dbMock = MockFirebaseEventsMenuAPI();
        final eventsMenuRepo = EventsMenuRepository(dbMock);
        getEventListReturns3Events(dbMock);

        expect(eventsMenuRepo.observeEventList(), emits([]));

        await eventsMenuRepo.fetchEventList();

        expect(
            eventsMenuRepo.observeEventList(),
            emits([
              Event(
                  name: "event1",
                  documentID: "document1",
                  startDate: testDate,
                  endDate: testDate),
              Event(
                  name: "event2",
                  documentID: "document2",
                  startDate: testDate,
                  endDate: testDate),
              Event(
                  name: "event3",
                  documentID: "document3",
                  startDate: testDate,
                  endDate: testDate),
            ]));
      });
    },
  );
}
