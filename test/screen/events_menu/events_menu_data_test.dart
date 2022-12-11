import 'package:flutter_test/flutter_test.dart';
import 'package:the_sss_store/screen/events_menu/events_menu_data.dart';
import 'package:the_sss_store/model/event.dart';

void main() {
  test('initial method is returning the correct data', () {
    EventsMenuData eventsMenuData = const EventsMenuData(
        eventButtonData: [],
        showEmptyState: false,
        showLoading: false,
        showCreateEventPopup: false,
        showRemoveEventPopup: false);

    EventsMenuData initialData = const EventsMenuData.initial();

    expect(initialData, eventsMenuData);
  });

  test('Event Button Data is correctly created from a Event Class instance', () {
    EventButtonData eventButtonData = const EventButtonData(name: "norte");
    Event event1 = const Event(name: "norte", documentID: "4435");
    Event event2 = const Event(name: "sul", documentID: "4435");

    EventButtonData newEventButtonData1 = EventButtonData.fromEvent(event1);
    EventButtonData newEventButtonData2 = EventButtonData.fromEvent(event2);

    expect(eventButtonData, newEventButtonData1);
    expect(eventButtonData != newEventButtonData2, true);
  });
}