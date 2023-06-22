import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import '../newPermission/new_permission.dart';
import '../services/event_json.dart';
import '/newPermission/components/background.dart';

const kheight = SizedBox(
  height: 15,
);

class appReq extends StatefulWidget {
  appReq({super.key});

  @override
  State<appReq> createState() => _appReqState();
}

class _appReqState extends State<appReq> {
  final commentsController = TextEditingController();

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      const background(),
      CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text(
              'Approved Request',
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
                  ElevatedButton(
                      onPressed: () async {
                        _gpt(event);
                      },
                      child: Text("Generate report"))
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
                      newPermission(), // Replace with your user dashboard screen
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

_gpt(Eventonperm event) async {
  var url = Uri.parse('https://api.openai.com/v1/chat/completions');
  print(url);
  var apikey = "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";
  Map<String, String> headers = {
    'Content-Type': 'application/json;charset=UTF-8',
    'Charset': 'utf-8',
    'Authorization': 'Bearer $apikey'
  };

  List messages = [
    {
      "role": "system",
      "content":
          "You are EventReportGPT an assistant that is tasked with writing an event report, User will send event details and you will respond with event report."
    },
    {"role": "user", "content": modelToString(event)},
    {"role": "user", "content": "Generate an event report for the above event."}
  ];
  final data = jsonEncode({
    "model": "gpt-3.5-turbo",
    "messages": messages,
    "temperature": 0.4,
    "max_tokens": 64,
    "top_p": 1,
    "frequency_penalty": 0,
    "presence_penalty": 0
  });
  print("boom!");
  var response = await http.post(url, headers: headers, body: data);
  print("bam!");
  if (response.statusCode == 200) {
    print(jsonDecode(response.body)["choices"][0]["message"]["content"]);
    return (jsonDecode(response.body)["choices"][0]["message"]["content"]);
  } else {
    print(response.body);
  }
}

Future<List<Eventonperm>> getAllEvents() async {
  try {
    QuerySnapshot eventsSnapshot = await FirebaseFirestore.instance
        .collection('events')
        .where('isApproved', isEqualTo: 1)
        .get();
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

String modelToString(Eventonperm model) {
  return '''
    id: ${model.id},
    eventName: ${model.eventName},
    organizingSociety: ${model.organizingSociety},
    eventLocation: ${model.eventLocation},
    scheduledDate: ${model.scheduledDate},
    startTime: ${model.startTime},
    endTime: ${model.endTime},
    eventDescription: ${model.eventDescription},
    posterImageUrl: ${model.posterImageUrl},
    pointOfContact: ${model.pointOfContact},
    pointOfContactPhone: ${model.pointOfContactPhone},
  ''';
}
