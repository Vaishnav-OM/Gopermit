import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateEventApprovalStatus(String eventId, bool isApproved) async {
  try {
    CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection('events');
    await eventsCollection.doc(eventId).update({'isApproved': isApproved});
  } catch (e) {
    print(e);
  }
}
