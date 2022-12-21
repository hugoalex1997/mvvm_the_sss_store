import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:the_sss_store/services/firebase/firebase_event_api.dart';
import 'package:the_sss_store/model/event.dart';

@singleton
class EventRepository {
  EventRepository(this._eventFirebase);

  final FirebaseEventAPI _eventFirebase;

  Future<Event> fetchEventData(String documentID) async {
    Map<String, dynamic> eventJson =
        await _eventFirebase.fetchEventData(documentID) as Map<String, dynamic>;
    return Event.fromJson(eventJson);
  }
}
