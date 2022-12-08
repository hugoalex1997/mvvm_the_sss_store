import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:the_sss_store/repository/events_menu_repository.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_view_model.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/model/event.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';

import 'events_menu_view_model_test.mocks.dart';

@GenerateMocks([EventsMenuRepository])
void main() {
  initializeGetIt();
  MockEventsMenuRepository eventsMenuRepository =
      MockEventsMenuRepository();
  EventsMenuViewModel eventsMenuViewModel =
      EventsMenuViewModel(eventsMenuRepository);

  List<Event> eventListForTests = [
    const Event(name: "event1", documentID: "document1"),
    const Event(name: "event2", documentID: "document2"),
    const Event(name: "event3", documentID: "document3"),
  ];

  setUp(() {
    eventsMenuRepository = MockEventsMenuRepository();
    eventsMenuViewModel = EventsMenuViewModel(eventsMenuRepository);

    when(eventsMenuRepository.observeEventList()).thenAnswer((_) {
      return Stream.value(eventListForTests);
    });
  });

  group('Test Events Menu View Model', () {
    test('Events Menu View Model constructor', () async {
      expect(eventsMenuViewModel.value, const EventsMenuData.initial());
    });
    test('Init fetching an empty list', () async {
      when(eventsMenuRepository.observeEventList()).thenAnswer((_) {
        return Stream.value([]);
      });
      await eventsMenuViewModel.init();

      expect(eventsMenuViewModel.value.eventButtonData, []);
      expect(eventsMenuViewModel.value.showEmptyState, true);
      verify(eventsMenuRepository.fetchEventList()).called(1);
    });

    test('Init fetching a non empty list', () async {
      when(eventsMenuRepository.observeEventList()).thenAnswer((_) {
        return Stream.value(eventListForTests);
      });

      await eventsMenuViewModel.init();

      expect(
        eventsMenuViewModel.value.eventButtonData,
        eventListForTests.map(EventButtonData.fromEvent).toList(),
      );
      expect(eventsMenuViewModel.value.showEmptyState, false);
      verify(eventsMenuRepository.fetchEventList()).called(1);
    });

    test('Create Event Popup flag is updated correctly', () async {
      await eventsMenuViewModel.init();

      expect(eventsMenuViewModel.value.showCreateEventPopup, false);

      eventsMenuViewModel.showCreateEventPopup();

      expect(eventsMenuViewModel.value.showCreateEventPopup, true);

      eventsMenuViewModel.hidePopup();

      expect(eventsMenuViewModel.value.showCreateEventPopup, false);
    });

    test('Remove Event Popup flag is updated correctly', () async {
      await eventsMenuViewModel.init();

      expect(eventsMenuViewModel.value.showRemoveEventPopup, false);

      eventsMenuViewModel.showRemoveEventPopup();

      expect(eventsMenuViewModel.value.showRemoveEventPopup, true);

      eventsMenuViewModel.hidePopup();

      expect(eventsMenuViewModel.value.showRemoveEventPopup, false);
    });

    test('Can create a Event', () async {
      await eventsMenuViewModel.init();

      expect(await eventsMenuViewModel.createEvent(""), false);
      expect(await eventsMenuViewModel.createEvent("Lust"), true);
    });

    group('Create Event', () {
      test('Can create a Event', () async {
        String eventName = "Lust";

        await eventsMenuViewModel.init();

        eventsMenuViewModel.createEvent(eventName);

        verify(eventsMenuViewModel
                .getEventsMenuRepository()
                .createEvent(eventName))
            .called(1);
        expect(await eventsMenuViewModel.createEvent(eventName), true);
      });

      test('Cant create a Event without a name', () async {
        String eventName = "";

        await eventsMenuViewModel.init();

        eventsMenuViewModel.createEvent(eventName);

        verifyNever(eventsMenuViewModel
            .getEventsMenuRepository()
            .createEvent(eventName));
        expect(await eventsMenuViewModel.createEvent(eventName), false);
      });
    });

    group('Remove Event ', () {
      test('Can remove a Event', () async {
        String eventName = "Lust";

        await eventsMenuViewModel.init();

        eventsMenuViewModel.removeEvent(eventName);

        verify(eventsMenuViewModel
                .getEventsMenuRepository()
                .removeEvent(eventName))
            .called(1);
        expect(await eventsMenuViewModel.removeEvent(eventName), true);
      });

      test('Cant remove a Event without a name', () async {
        String eventName = "";

        await eventsMenuViewModel.init();

        eventsMenuViewModel.removeEvent(eventName);

        verifyNever(eventsMenuViewModel
            .getEventsMenuRepository()
            .removeEvent(eventName));
        expect(await eventsMenuViewModel.removeEvent(eventName), false);
      });
    });
  });
}
