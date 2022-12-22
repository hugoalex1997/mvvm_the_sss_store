import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:the_sss_store/common/data/popup_data.dart';

import 'package:the_sss_store/repository/events_menu_repository.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_view_model.dart';
import 'package:the_sss_store/inject/dependency_injection.dart';
import 'package:the_sss_store/model/event.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';

import 'events_menu_view_model_test.mocks.dart';

@GenerateMocks([EventsMenuRepository])
void main() {
  initializeGetIt();
  MockEventsMenuRepository eventsMenuRepository = MockEventsMenuRepository();
  EventsMenuViewModel eventsMenuViewModel =
      EventsMenuViewModel(eventsMenuRepository);
  DateTime testDate = DateTime.now();
  List<Event> eventListForTests = [
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
      expect(eventsMenuViewModel.value.eventButtonData,
          EventsMenuData.initial().eventButtonData);
      expect(eventsMenuViewModel.value.showEmptyState,
          EventsMenuData.initial().showEmptyState);
      expect(eventsMenuViewModel.value.showLoading,
          EventsMenuData.initial().showLoading);
      expect(eventsMenuViewModel.value.removeEventPopup,
          EventsMenuData.initial().removeEventPopup);
      //NOTE: This is expected since timestamp of each initial method call is different
      expect(
          eventsMenuViewModel.value.createEventPopup !=
              EventsMenuData.initial().createEventPopup,
          true);
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

    test('Create Event Popup data is updated correctly', () async {
      await eventsMenuViewModel.init();

      expect(eventsMenuViewModel.value.createEventPopup.visible,
          CreateEventPopupData.initial().visible);

      eventsMenuViewModel.showCreateEventPopup();

      expect(eventsMenuViewModel.value.createEventPopup.visible,
          CreateEventPopupData.show().visible);

      eventsMenuViewModel.hidePopup();

      expect(eventsMenuViewModel.value.createEventPopup.visible,
          CreateEventPopupData.initial().visible);
    });

    test('Remove Event Popup data is updated correctly', () async {
      await eventsMenuViewModel.init();

      expect(eventsMenuViewModel.value.removeEventPopup,
          const PopupData.initial());

      eventsMenuViewModel.showRemoveEventPopup();

      expect(
          eventsMenuViewModel.value.removeEventPopup, const PopupData.show());

      eventsMenuViewModel.hidePopup();

      expect(eventsMenuViewModel.value.removeEventPopup,
          const PopupData.initial());
    });

    group('Create Event', () {
      test('Can create a Event', () async {
        String eventName = "Lust";

        await eventsMenuViewModel.init();

        eventsMenuViewModel.setStartDate(testDate);
        eventsMenuViewModel.setEndDate(testDate);

        eventsMenuViewModel.createEvent(eventName);

        verify(eventsMenuViewModel
                .getEventsMenuRepository()
                .createEvent(eventName, testDate, testDate))
            .called(1);
        expect(await eventsMenuViewModel.createEvent(eventName), true);
      });

      test('Cant create a Event without a name', () async {
        String eventName = "";

        await eventsMenuViewModel.init();

        eventsMenuViewModel.setStartDate(testDate);
        eventsMenuViewModel.setEndDate(testDate);

        eventsMenuViewModel.createEvent(eventName);

        verifyNever(eventsMenuViewModel
            .getEventsMenuRepository()
            .createEvent(eventName, testDate, testDate));
        expect(await eventsMenuViewModel.createEvent(eventName), false);
        expect(
            eventsMenuViewModel.value.createEventPopup.error,
            CreateEventPopupData.error(
                    "Deve inserir um nome!", testDate, testDate)
                .error);
      });

      //TODO: Add tests to startDate and EndDate scenarios
      test('Cant create a event with an ivalid date', () async {
        String eventName = "TestInvalidDate";
        DateTime startDateTest = DateTime.utc(2050, 3, 5);
        DateTime endDateTest = DateTime.utc(2000, 3, 5);

        await eventsMenuViewModel.init();

        eventsMenuViewModel.setStartDate(startDateTest);
        eventsMenuViewModel.setEndDate(endDateTest);

        eventsMenuViewModel.createEvent(eventName);

        verifyNever(eventsMenuViewModel
            .getEventsMenuRepository()
            .createEvent(eventName, testDate, testDate));
        expect(await eventsMenuViewModel.createEvent(eventName), false);
        expect(
            eventsMenuViewModel.value.createEventPopup.error,
            CreateEventPopupData.error(
                    "Data inválida!", startDateTest, endDateTest)
                .error);
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
        expect(eventsMenuViewModel.value.removeEventPopup,
            const PopupData.error("Nenhum evento selecionado!"));
      });
    });
  });
}
