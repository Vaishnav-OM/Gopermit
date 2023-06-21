import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../services/event_json.dart';

// void main() => runApp(MaterialApp(
//       home: MyApp(),
//     ));

class scheduledDetails extends StatelessWidget {
  final String eventId;

  scheduledDetails({required this.eventId});
  final commentsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Eventonperm>(
      future: fetchEventDetails(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Eventonperm event = snapshot.data!;
          return Scaffold(
              backgroundColor: Colors.black,
              body: Center(
                  child: Container(
                // decoration: BoxDecoration(
                //   image: DecorationImage(
                //       fit: BoxFit.fill,
                //       image: AssetImage("assets/images/bg_design.png")),
                // ),
                child: CustomScrollView(slivers: <Widget>[
                  SliverAppBar(
                    title: Text(
                      event.eventName,
                      style: const TextStyle(
                        color: Colors.white,
                        // fontFamily: "Poppins-Medium",
                        fontSize: 20,
                      ),
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
                    delegate: SliverChildListDelegate.fixed(
                      [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0.0),
                          child: SizedBox(
                            width: 750.0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image.asset(
                                  //   'assets/images/eventdet.jpg',
                                  // ),
                                  const SizedBox(
                                    height: 10.0,
                                  ),

                                  Row(
                                    children: [
                                      Text('Date',
                                          style: TextStyle(
                                              // fontFamily: 'Poppins-Medium',
                                              color: Colors.grey[900],
                                              // letterSpacing: 2.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 50),
                                      Text('18th September 2022',
                                          style: TextStyle(
                                            // fontFamily: 'Poppins-Medium',
                                            color: Colors.grey[900],
                                            letterSpacing: 2.0,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Text('Time',
                                          style: TextStyle(
                                              // fontFamily: 'Poppins-Medium',
                                              color: Colors.grey[900],
                                              // letterSpacing: 2.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 112),
                                      Text('12 - 2 PM',
                                          style: TextStyle(
                                            // fontFamily: 'Poppins-Medium',
                                            color: Colors.grey[900],
                                            // letterSpacing: 2.0,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Row(
                                    children: [
                                      Text('Location',
                                          style: TextStyle(
                                              // fontFamily: 'Poppins-Medium',
                                              color: Colors.grey[900],
                                              // letterSpacing: 2.0,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 80),
                                      Text(event.eventLocation,
                                          style: TextStyle(
                                            // fontFamily: 'Poppins-Medium',
                                            color: Colors.grey[900],
                                            // letterSpacing: 2.0,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text('Description',
                                      style: TextStyle(
                                          // fontFamily: 'Poppins-Medium',
                                          color: Colors.grey[900],
                                          // letterSpacing: 2.0,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                  Text(event.eventDescription,
                                      style: TextStyle(
                                        // fontFamily: 'Poppins-Medium',
                                        color: Colors.grey[900],
                                        // letterSpacing: 2.0,
                                      )),
                                  SizedBox(
                                    height: 15.0,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              )));
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return CircularProgressIndicator.adaptive();
        }
      },
    );
  }

  Future<Eventonperm> fetchEventDetails() async {
    try {
      DocumentSnapshot events = await FirebaseFirestore.instance
          .collection('events')
          .doc(eventId)
          .get();

      Eventonperm eventssnap = Eventonperm(
          id: events.id,
          eventName: events['eventName'],
          organizingSociety: events['organizingSociety'],
          eventLocation: events['eventLocation'],
          scheduledDate: events['scheduledDate'].toDate(),
          // startTime: TimeOfDay.fromDateTime(doc['startTime'].toDate()),
          // endTime: TimeOfDay.fromDateTime(doc['endTime'].toDate()),
          eventDescription: events['eventDescription'],
          posterImageUrl: events['posterImageUrl'],
          pointOfContact: events['pointOfContact'],
          pointOfContactPhone: events['pointOfContactPhone'],
          comment: events['comment'],
          isApproved: events['isApproved'],
          uid: events['uid']);
      return eventssnap;
    } catch (e) {
      // Handle any errors that occur
      //print(e);
      return Eventonperm(
        id: '',
        eventName: '',
        eventDescription: '',
        eventLocation: '',
        organizingSociety: '',
        pointOfContact: '',
        pointOfContactPhone: '',
        posterImageUrl: '',
        scheduledDate: DateTime.now(),
        uid: "",
      ); // Return an empty event or handle the error case
    }
  }
}
