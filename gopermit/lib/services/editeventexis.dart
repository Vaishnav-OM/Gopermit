import 'event_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> editEvent(Eventonperm updatedEvent) async {
  try {
    CollectionReference eventsCollection =
        FirebaseFirestore.instance.collection('events');
    await eventsCollection.doc(updatedEvent.id).update({
      'eventName': updatedEvent.eventName,
      'organizingSociety': updatedEvent.organizingSociety,
      'eventLocation': updatedEvent.eventLocation,
      // 'scheduledDate': updatedEvent.scheduledDate,
      // 'startTime': updatedEvent.startTime,
      // 'endTime': updatedEvent.endTime,
      'posterImageUrl': updatedEvent.posterImageUrl,
      'pointOfContact': updatedEvent.pointOfContact,
      'pointOfContactPhone': updatedEvent.pointOfContactPhone,
      'comment': updatedEvent.comment,
      'isApproved': updatedEvent.isApproved,
    });
  } catch (e) {
    // Handle any errors that occur
    print(e);
  }
}
