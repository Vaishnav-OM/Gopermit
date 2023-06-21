import 'event_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addEvent(Eventonperm event) async {
  CollectionReference eventsCollection =
      FirebaseFirestore.instance.collection('events');
  DocumentReference newEventDocRef = await eventsCollection.add({
    'eventName': event.eventName,
    'organizingSociety': event.organizingSociety,
    'eventLocation': event.eventLocation,
    // 'scheduledDate': event.scheduledDate,
    // 'startTime': event.startTime,
    // 'endTime': event.endTime,
    'eventDescription': event.eventDescription,
    'posterImageUrl': event.posterImageUrl,
    'pointOfContact': event.pointOfContact,
    'pointOfContactPhone': event.pointOfContactPhone,
    'comment': event.comment,
    'isApproved': event.isApproved,
    'uid': event.uid
  });
  event.id = newEventDocRef.id;
  // ignore: avoid_print
  print(event.id);
}
