import 'package:flutter/material.dart';
import 'package:gop2/landingPage/body.dart';
import 'package:gop2/loginPage/login_page.dart';
import 'package:gop2/newPermission/new_permission.dart';
import 'package:gop2/scheduledEvents/body.dart';
import 'package:gop2/approvedRequest/body.dart';
import 'package:gop2/rejectedRequest/body.dart';
import 'package:gop2/holdRequests/body.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../services/allevent_json.dart';
import '../services/event_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/src/painting/image_resolution.dart';

// void main() {
//   runApp(const GoPermit());
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
        uid: doc['uid'],
      ));
    });

    return events;
  } catch (e) {
    return [];
  }
}

Future<int> getTotalRequests(uid) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('events')
      .where('uid', isEqualTo: uid)
      .get();
  return snapshot.size;
}

Future<int> getApprovedRequests(uid) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('events')
      .where('isApproved', isEqualTo: 1)
      .get();
  return snapshot.size;
}

Future<int> getRejectedRequests(uid) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('events')
      .where('isApproved', isEqualTo: -1)
      .get();
  return snapshot.size;
}

Future<int> getHoldRequests(uid) async {
  final snapshot = await FirebaseFirestore.instance
      .collection('events')
      .where('isApproved', isEqualTo: 0)
      .get();
  return snapshot.size;
}

class UserDashBoard extends StatefulWidget {
  const UserDashBoard({Key? key, required this.uid}) : super(key: key);

  final String? uid;

  @override
  State<UserDashBoard> createState() => _UserDashBoardState();
}

class _UserDashBoardState extends State<UserDashBoard> {
  List<Eventonperm> events = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Go Permit',
      home: DashboardScreen(uid: widget.uid),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatefulWidget {
  DashboardScreen({Key? key, required this.uid}) : super(key: key);
  String? uid;
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

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      widget.uid = null;
    } catch (e) {
      print('Error signing out: $e');
      // Handle sign-out error
    }
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
            signOut();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          },
        ),
        title: const Text(
          'Dashboard',
          style: TextStyle(
              fontSize: 20, fontFamily: 'Poppins', fontWeight: FontWeight.w900),
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
        future: getTotalRequests(widget.uid),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final totalRequests = snapshot.data;
            final approvedRequests = events
                .where(
                    (event) => event.isApproved == 1 && event.uid == widget.uid)
                .toList();

            final rejectedRequests = events
                .where((event) =>
                    event.isApproved == -1 && event.uid == widget.uid)
                .toList();
            final holdRequests = events
                .where(
                    (event) => event.isApproved == 0 && event.uid == widget.uid)
                .toList();
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
                            value: approvedRequests.length.toString(),
                            context: context,
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
                            value: rejectedRequests.length.toString(),
                            context: context,
                          ),
                          const SizedBox(
                            height: 8.0,
                            width: 8.0,
                          ),
                          _buildMetricBlock3(
                            title: 'Requests on Hold',
                            value: holdRequests.length.toString(),
                            context: context,
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
                  'Requests on Hold',
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newPermission()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

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
  required BuildContext context,
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
  required BuildContext context,
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
  required BuildContext context,
}) {
  return GestureDetector(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(10),
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

class EventOnHoldCard extends StatelessWidget {
  final Eventonperm event;
  const EventOnHoldCard({super.key, required this.event});

  get decoration => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => scheduledDetails(
                      eventId: event.id,
                      isApproved: event.isApproved,
                    )));
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 228, 226, 226),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Container(
            // height: 100.0,
            //width: 100.0,
            //color: Colors.grey[300],
            //margin: const EdgeInsets.all(8.0),
            //),
            const Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AMA Session with Devikaa D',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Text(
                      'TinkerHub',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 14.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '24th January 2023',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Icon(
                          Icons.access_time,
                          size: 14.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          '4pm - 5pm',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          size: 14.0,
                          color: Colors.black,
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          'Room No 312',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              // ignore: sort_child_properties_last
              // ignore: prefer_const_constructors

              height: 50,
              width: 50,
              margin: const EdgeInsets.all(16.0),
              // child: Image.asset('assets/images/bg_design'),
              //fit: BoxFit.cover,
              //height: 40,
              //width: 40,
            ),
          ],
        ),
      ),
    );
  }
}
