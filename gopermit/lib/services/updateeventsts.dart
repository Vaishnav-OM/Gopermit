import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateEventApprovalStatus(
  String eventId,
  int isApproved,
) async {
  try {
    CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection('events');
    await eventsCollection.doc(eventId).update({'isApproved': 1});
  } catch (e) {
    print(e);
  }
}
