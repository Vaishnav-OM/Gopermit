import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gop2/newPermission/components/background.dart';
import 'package:intl/intl.dart';
// ignore: depend_on_referenced_packages
import '/loginPage/login_page.dart';
import "package:gop2/scheduledEvents/body.dart";
import 'package:gop2/services/event_json.dart';
import '../services/allevent_json.dart';
import '../services/event_json.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'My App',
//       home: HomeScreen(),
//     );
//   }
// }
Future<List<Eventonperm>> getAllEvents() async {
  try {
    QuerySnapshot eventsSnapshot =
        await FirebaseFirestore.instance.collection('events').get();
    List<Eventonperm> events = [];
    List<Eventonperm> unapprovedEvents = [];

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

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        title: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Good Morning',
                style: TextStyle(
                    // fontFamily: "Oleo Script",
                    fontSize: 24,
                    fontWeight: FontWeight.bold))),
        actions: [
          TextButtonTheme(
            data: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  // fontFamily: 'Roboto',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
              child: const Text(
                'Login',
                style: TextStyle(
                    // fontFamily: "Poppins",
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body:
          // Stack(
          // children: [
          //   Positioned.fill(
          //     child: Image.asset(
          //       "assets/images/background_image1.png",
          //       fit: BoxFit.cover,
          //     ),
          //   ),
          Container(
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /*
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                hintText: 'Enter department or society',
                hintStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            */
            const SizedBox(height: 16.0),
            const Text(
              'Scheduled Events',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  Eventonperm event = events[index];
                  return EventCard(event: event);
                },
              ),
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Events on Hold',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: events.length,
                itemBuilder: (context, index) {
                  Eventonperm event = events[index];
                  return EventOnHoldCard(event: event);
                },
              ),
            ),
          ],
        ),
      ),
      // ],
      // ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Eventonperm event;

  EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    String day = event.scheduledDate!.day.toString();
    String month = event.scheduledDate!.month.toString();
    String year = event.scheduledDate!.year.toString();
    var st = event.startTime;
    var et = event.endTime;
    print(event.posterImageUrl);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => scheduledDetails(
                    eventId: event.id,
                    isApproved: event.isApproved,
                  )),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              child: Image.network(
                event.posterImageUrl,
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.fill,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    event.eventName,
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today,
                            size: 16.0,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4.0),
                          Text(
                            '$day' '/' '$month' '/' '$year',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 16.0,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4.0),
                      Row(
                        children: [
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
                              fontSize: 13.0,
                            ),
                          ),
                        ],
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
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => scheduledDetails(
                    eventId: event.id,
                    isApproved: event.isApproved,
                  )),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      event.eventName,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
                    Text(
                      event.organizingSociety,
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(height: 6.0),
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
                      ],
                    ),
                    const SizedBox(height: 8.0),
                    Row(
                      children: [
                        // const SizedBox(width: 20.0),
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
                    const SizedBox(height: 8.0),
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
          ],
        ),
      ),
    );
  }
}
