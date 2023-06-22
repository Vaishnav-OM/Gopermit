import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../newPermission/new_permission.dart';
import '../services/event_json.dart';
import '/newPermission/components/background.dart';

const kheight = SizedBox(
  height: 15,
);

Future<List<Eventonperm>> getAllEvents() async {
  try {
    QuerySnapshot eventsSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('isApproved', isEqualTo: -1)
        .get();
    List<Eventonperm> events = [];

    eventsSnapshot.docs.forEach((doc) {
      events.add(Eventonperm(
          id: doc.id,
          eventName: doc['eventName'],
          organizingSociety: doc['organizingSociety'],
          eventLocation: doc['eventLocation'],
          scheduledDate: doc['scheduledDate'].toDate(),
          startTime: doc['startTime'],
          endTime: doc['endTime'],
          eventDescription: doc['eventDescription'],
          posterImageUrl: doc['posterImageUrl'],
          pointOfContact: doc['pointOfContact'],
          pointOfContactPhone: doc['pointOfContactPhone'],
          comment: doc['comment'],
          isApproved: doc['isApproved'],
          uid: doc['uid']));
    });

    return events;
  } catch (e) {
    print(e);
    return [];
  }
}

class appRej extends StatefulWidget {
  appRej({super.key});

  @override
  State<appRej> createState() => _appRejState();
}

class _appRejState extends State<appRej> {
  List<Eventonperm> events = [];

  @override
  void initState() {
    super.initState();
    fetchEvents();
  }

  Future<void> fetchEvents() async {
    List<Eventonperm> fetchedEvents = await getAllEvents();
    setState(() {
      events = fetchedEvents;
      print(events);
    });
  }

  final commentsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const background(),
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text(
              'Rejected Request',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            pinned: false,
            snap: false,
            floating: false,
            backgroundColor: Colors.transparent,
            centerTitle: true,
          ),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: ListView.builder(
                      shrinkWrap: true,

                      itemCount: events
                          .length, // Replace 'events' with your list of events
                      itemBuilder: (context, index) {
                        return EventOnHoldCard(event: events[index]);
                      },
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ],
      )
    ]));
  }
}

class EventOnHoldCard extends StatelessWidget {
  final Eventonperm event;
  const EventOnHoldCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String day = event.scheduledDate!.day.toString();
    String month = event.scheduledDate!.month.toString();
    String year = event.scheduledDate!.year.toString();
    var st = event.startTime;
    var et = event.endTime;
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 90.0,
            width: double.minPositive,
            color: Colors.grey,
            margin: const EdgeInsets.all(8.0),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventName,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    event.eventDescription,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14.0,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '$day' '/' '$month' '/' '$year',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12.0,
                        ),
                      ),
                      const SizedBox(width: 8.0),
                      Icon(
                        Icons.access_time,
                        size: 14.0,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        '$st' '-' '$et',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4.0),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 14.0,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        event.eventLocation,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const newPermission(), // Replace with your user dashboard screen
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
