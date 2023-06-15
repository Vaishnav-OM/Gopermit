import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addCommentToEvent(String eventId, String comment) async {
  try {
    CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection('events');
    await eventsCollection.doc(eventId).update({'comment': comment});
  } catch (e) {
    // Handle any errors that occur
  }
}
