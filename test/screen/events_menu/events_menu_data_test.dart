import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/common/data/popup_data.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';
import 'package:the_sss_store/model/event.dart';

void main() {
  test('initial method is returning the correct data', () {
    EventsMenuData eventsMenuData = EventsMenuData(
        eventButtonData: const [],
        showEmptyState: false,
        showLoading: false,
        createEventPopup: CreateEventPopupData.initial(),
        removeEventPopup: const PopupData.initial());

    EventsMenuData initialData = EventsMenuData.initial();

    expect(initialData.eventButtonData, eventsMenuData.eventButtonData);
    expect(initialData.showEmptyState, eventsMenuData.showEmptyState);
    expect(initialData.showLoading, eventsMenuData.showLoading);
    expect(initialData.removeEventPopup, eventsMenuData.removeEventPopup);
    //NOTE: This is expected since timestamp of each initial method call is different
    expect(
        initialData.createEventPopup != eventsMenuData.createEventPopup, true);
  });

  test('Event Button Data is correctly created from a Event Class instance',
      () {
    DateTime testDate = DateTime.now();
    EventButtonData eventButtonData = const EventButtonData(name: "Queima");
    Event event1 = Event(
        name: "Queima",
        documentID: "4435",
        startDate: testDate,
        endDate: testDate);
    Event event2 = Event(
        name: "Sudoeste",
        documentID: "4435",
        startDate: testDate,
        endDate: testDate);

    EventButtonData newEventButtonData1 = EventButtonData.fromEvent(event1);
    EventButtonData newEventButtonData2 = EventButtonData.fromEvent(event2);

    expect(eventButtonData, newEventButtonData1);
    expect(eventButtonData != newEventButtonData2, true);
  });
}
