import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import 'package:the_sss_store/model/event.dart';

//TODO: Handle Error scenarios
@singleton
class FirebaseEventsAPI {
  final String eventsCollectionName = "events";

  CollectionReference getEventsCollection() {
    return FirebaseFirestore.instance.collection(eventsCollectionName);
  }

  DocumentReference getEventDocument(String eventDocumentID) {
    return getEventsCollection().doc(eventDocumentID);
  }

  Stream<List<Event>> getEventList() {
    CollectionReference eventsCollection = getEventsCollection();

    return eventsCollection.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>))
              .toList(),
        );
  }

  Future<String?> getEventDocumentID(String name) async {
    CollectionReference eventsCollection = getEventsCollection();

    QuerySnapshot storagesCollectionSnapshot = await eventsCollection.get();
    Iterable<Event> storagesDocumentsData = storagesCollectionSnapshot.docs
        .map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>));

    for (int index = 0; index < storagesDocumentsData.length; index++) {
      String eventName = storagesDocumentsData.elementAt(index).name;
      if (eventName == name) {
        String documentID = storagesDocumentsData.elementAt(index).documentID;
        return documentID;
      }
    }
    return null;
  }

  void createEvent(String eventName) {
    CollectionReference eventsCollection = getEventsCollection();
    DocumentReference newEventDocument = eventsCollection.doc();
    newEventDocument
        .set(Event(name: eventName, documentID: newEventDocument.id).toJson());
  }

  void removeEvent(String name) {
    CollectionReference eventsCollection = getEventsCollection();

    getEventDocumentID(name).then((String? documentID) {
      if (documentID == null) {
        //Error Handling
      } else {
        eventsCollection.doc(documentID).delete();
      }
    });
  }

  Future<bool> eventFound(String name) async {
    String? documentID = await getEventDocumentID(name);

    return documentID == null ? false : true;
  }
}
