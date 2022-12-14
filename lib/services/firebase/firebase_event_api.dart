import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@singleton
class FirebaseStorageAPI {
  final String eventsCollectionName = "events";

  CollectionReference _getEventsCollection() {
    return FirebaseFirestore.instance.collection(eventsCollectionName);
  }

  DocumentReference getEventDocument(String documentID) {
    return _getEventsCollection().doc(documentID);
  }
}
