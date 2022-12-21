import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirebaseEventAPI {
  final String eventsCollectionName = "events";

  CollectionReference _getEventsCollection() {
    return FirebaseFirestore.instance.collection(eventsCollectionName);
  }

  DocumentReference getEventDocument(String documentID) {
    return _getEventsCollection().doc(documentID);
  }

  Future<Object?> fetchEventData(String documentID) async {
    DocumentReference eventDocument = getEventDocument(documentID);
    DocumentSnapshot eventSnapshot = await eventDocument.get();
    return eventSnapshot.data();
  }

  // DateTime getEventEndDate() {}
}
