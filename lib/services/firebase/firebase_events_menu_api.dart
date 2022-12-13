import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:the_sss_store/model/event.dart';

//TODO: Handle Error scenarios
@singleton
class FirebaseEventsMenuAPI {
  final String eventsCollectionName = "events";

  CollectionReference _getEventsCollection() {
    return FirebaseFirestore.instance.collection(eventsCollectionName);
  }

  Future<List<Event>> getEventsList() async {
    CollectionReference eventsCollection = _getEventsCollection();

    QuerySnapshot eventsSnapshot = await eventsCollection.get();

    Iterable<Event> eventsDocumentsData = eventsSnapshot.docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>));

    List<Event> eventList = [];
    for (final event in eventsDocumentsData) {
      eventList.add(event);
    }

    return eventList;
  }

  Future<String?> getEventDocumentID(String name) async {
    CollectionReference eventsCollection = _getEventsCollection();

    QuerySnapshot eventsSnapshot = await eventsCollection.get();
    Iterable<Event> eventsDocumentsData = eventsSnapshot.docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>));

    for (int index = 0; index < eventsDocumentsData.length; index++) {
      String eventName = eventsDocumentsData.elementAt(index).name;
      if (eventName == name) {
        String documentID = eventsDocumentsData.elementAt(index).documentID;
        return documentID;
      }
    }
    return null;
  }

  Event createEvent(String eventName) {
    CollectionReference eventsCollection = _getEventsCollection();
    DocumentReference newEventDocument = eventsCollection.doc();

    Event event = Event(name: eventName, documentID: newEventDocument.id);
    newEventDocument.set(event.toJson());
    return event;
  }

  Future<void> removeEvent(String name) async {
    CollectionReference eventsCollection = _getEventsCollection();

    QuerySnapshot eventsCollectionSnapshot = await eventsCollection.get();
    Iterable<Event> eventsDocumentsData = eventsCollectionSnapshot.docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>));

    for (int index = 0; index < eventsDocumentsData.length; index++) {
      String eventName = eventsDocumentsData.elementAt(index).name;
      if (eventName == name) {
        String documentID = eventsDocumentsData.elementAt(index).documentID;
        eventsCollection.doc(documentID).delete();
        return;
      }
    }
  }

  Future<bool> eventFound(String name) async {
    String? documentID = await getEventDocumentID(name);

    return documentID == null ? false : true;
  }
}
