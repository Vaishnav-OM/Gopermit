import 'package:flutter/material.dart';
import 'package:gop2/holdRequests/body.dart';
import 'package:gop2/loginPage/login_page.dart';
import 'package:gop2/principalSide/principal_side_permission_screen.dart';
import '../services/allevent_json.dart';
import '../services/event_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gop2/approvedRequest/body.dart';
import 'package:gop2/rejectedRequest/body.dart';

import '../services/updateeventsts.dart';

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
        // startTime: TimeOfDay.fromDateTime(doc['startTime'].toDate()),
        // endTime: TimeOfDay.fromDateTime(doc['endTime'].toDate()),
        eventDescription: doc['eventDescription'],
        posterImageUrl: doc['posterImageUrl'],
        pointOfContact: doc['pointOfContact'],
        pointOfContactPhone: doc['pointOfContactPhone'],
        comment: doc['comment'],
        isApproved: doc['isApproved'],
        uid: doc['uid'],
      ));
    });

    return events;
  } catch (e) {
    return [];
  }
}

Future<int> getTotalRequests() async {
  final snapshot = await FirebaseFirestore.instance.collection('events').get();
  return snapshot.size;
}

// ignore: camel_case_types
class princDashBoard extends StatefulWidget {
  const princDashBoard({super.key});

  @override
  State<princDashBoard> createState() => _princDashBoardState();
}

class _princDashBoardState extends State<princDashBoard> {
  List<Eventonperm> events = [];
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'Go Permit',
        home: DashboardScreen(),
        debugShowCheckedModeBanner: false);
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
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

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
          toolbarHeight: 50,
          // flexibleSpace: Container(
          //   decoration: BoxDecoration(
          //     image: DecorationImage(
          //       image: "assets/images/bg_design.png"
          //       fit: BoxFit.cover,
          //     ),

          //   ),
          // ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginPage()));
            },
          ),
          title: const Text(
            'Dashboard',
            style: TextStyle(
                fontSize: 20,
                fontFamily: 'Poppins',
                fontWeight: FontWeight.w900),
          ),
        ),
        body:
            // child: Container(
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('assets/bg_design'),
            //       fit: BoxFit.cover,
            //     ),
            //   ),
            FutureBuilder<int>(
                future: getTotalRequests(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final totalRequests = snapshot.data;

                    return Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _buildMetricBlock(
                                    title: 'Total Requests Initiated',
                                    value: totalRequests.toString(),
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                    width: 8.0,
                                  ),
                                  _buildMetricBlock1(
                                    title: 'Requests Approved',
                                    value: '6',
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                    width: 8.0,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  _buildMetricBlock2(
                                    title: 'Requests Rejected',
                                    value: '2',
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                    width: 8.0,
                                  ),
                                  _buildMetricBlock3(
                                    title: 'Requests on Hold',
                                    value: '2',
                                  ),
                                  const SizedBox(
                                    height: 8.0,
                                    width: 8.0,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Text(
                          'Awaiting Approval',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Expanded(
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: events.length,
                            itemBuilder: (context, index) {
                              Eventonperm event = events[index];
                              return EventCard(event: event);
                            },
                          ),
                        ),
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator.adaptive();
                  }
                }));

    // floatingActionButton: FloatingActionButton(
    // onPressed: () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => newPermission()),
    //   );
    // },
    //     child: const Icon(Icons.add),
    //   ),
    // );
    // ),
    // );
  }

  Widget _buildMetricBlock({
    required String title,
    required String value,
  }) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 167.0,
      height: 154.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              // fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 19.0,
            ),
          ),
          const SizedBox(height: 16.0),
          Text(
            value,
            style: const TextStyle(
              // fontFamily: GoogleFonts.poppins().fontFamily,
              fontWeight: FontWeight.bold,
              fontSize: 40.0,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricBlock1({
    required String title,
    required String value,
  }) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => appReq()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: 144.0,
          height: 190.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                value,
                style: const TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildMetricBlock2({
    required String title,
    required String value,
  }) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => appRej()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          width: 140.0,
          height: 166.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(
                value,
                style: const TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildMetricBlock3({
    required String title,
    required String value,
  }) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => appHold()),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 167.0,
          height: 131.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: const TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 19.0,
                ),
              ),
              const SizedBox(height: 16.0),
              Text(
                value,
                style: const TextStyle(
                  // fontFamily: GoogleFonts.poppins().fontFamily,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0,
                ),
              ),
            ],
          ),
        ));
  }
}

class EventCard extends StatelessWidget {
  final Eventonperm event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PrincipalSidePermissionScreen(
                    eventId: event.id,
                    isApproved: event.isApproved,
                  )),
        );
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 228, 226, 226),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10.0),
              ),
              /*
              child: Image.asset(
                'assets/images/eventcard.jpg',
                height: 150.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              */
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
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14.0,
                        color: Colors.grey[600],
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Event Date',
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
                        'Event Time',
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
                          fontSize: 11.0,
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
