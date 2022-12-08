import 'dart:async';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:the_sss_store/model/event.dart';
import 'package:the_sss_store/services/firebase/firebase_events_menu_api.dart';

@singleton
class EventsMenuRepository {
  EventsMenuRepository(this._eventsMenuFirebase);

  final FirebaseEventsMenuAPI _eventsMenuFirebase;

  List<Event> _eventList = [];
  final _eventListSC = StreamController<List<Event>>.broadcast();

  @visibleForTesting
  List<Event> getEventList() {
    return _eventList;
  }

  Stream<List<Event>> observeEventList() async* {
    yield _eventList;
    yield* _eventListSC.stream;
  }

  Future<void> fetchEventList() async {
    _eventList = await _eventsMenuFirebase.getEventsList();
    _eventListSC.add(_eventList);
  }

  void createEvent(String name) {
    _eventsMenuFirebase.createEvent(name);
    fetchEventList();
  }

  void removeEvent(String name) async {
    await _eventsMenuFirebase.removeEvent(name);
    fetchEventList();
  }
}
