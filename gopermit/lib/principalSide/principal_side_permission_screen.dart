import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
//import '../newPermission/components/body.dart';
import '/newPermission/components/background.dart';
import '../services/event_json.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

const kheight = SizedBox(
  height: 15,
);

// ignore: must_be_immutable
class PrincipalSidePermissionScreen extends StatelessWidget {
  final String eventId;

  var isApproved;
  PrincipalSidePermissionScreen(
      {super.key, required this.isApproved, required this.eventId});
  final commentsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Eventonperm>(
        future: fetchEventDetails(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Eventonperm event = snapshot.data!;
            return Scaffold(
                body: Stack(
              children: [
                const background(),
                CustomScrollView(
                  slivers: <Widget>[
                    SliverAppBar(
                      title: Text(
                        event.eventName,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleWithDetailWidget(
                                      title: 'Event Name',
                                      details: event.eventName),
                                  TitleWithDetailWidget(
                                      title: 'Organizing Society',
                                      details: event.organizingSociety),
                                  TitleWithDetailWidget(
                                      title:
                                          'Event Location/ Utility Centre - I',
                                      details: event.eventLocation),

                                  ///implement following using DateTime
                                  const TitleWithDetailWidget(
                                      title: 'Date',
                                      details: "18th September 2023"),
                                  const Row(
                                    children: [
                                      TitleWithDetailWidget(
                                          title: 'Starting Time',
                                          details: "4:00 PM"),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      TitleWithDetailWidget(
                                          title: 'Ending Time',
                                          details: "6:00 PM"),
                                    ],
                                  ),
                                  TitleWithDetailWidget(
                                      title: 'Event Description',
                                      details: event.eventDescription),
                                  TitleWithDetailWidget(
                                      title: 'Point of Contact',
                                      details: event.pointOfContact),
                                  _CommentsSection(
                                    controller: commentsController,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      DecisionButtonWidget(
                                        buttonText: 'APPROVE',
                                        onPressed: () {},
                                      ),
                                      DecisionButtonWidget(
                                        buttonText: 'REJECT',
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ]),
                    ),
                  ],
                ),
              ],
            ));
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return CircularProgressIndicator.adaptive();
          }
        });
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
        //scheduledDate: events['scheduledDate'].toDate(),
        // startTime: TimeOfDay.fromDateTime(doc['startTime'].toDate()),
        // endTime: TimeOfDay.fromDateTime(doc['endTime'].toDate()),
        eventDescription: events['eventDescription'],
        posterImageUrl: events['posterImageUrl'],
        pointOfContact: events['pointOfContact'],
        pointOfContactPhone: events['pointOfContactPhone'],
        comment: events['comment'],
        isApproved: events['isApproved'],
        uid: events['uid'],
      );
      return eventssnap;
    } catch (e) {
      // Handle any errors that occur
      print(e);
      return Eventonperm(
          id: '',
          eventName: '',
          eventDescription: '',
          eventLocation: '',
          organizingSociety: '',
          pointOfContact: '',
          pointOfContactPhone: '',
          posterImageUrl: '',
          // scheduledDate: DateTime.now(),
          uid: ""); // Return an empty event or handle the error case
    }
  }
}

class _CommentsSection extends StatelessWidget {
  const _CommentsSection({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Comments',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            )),
        kheight,
        TextFormField(
          controller: controller,
          maxLines: 4,
          decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide(width: 1))),
        ),
        kheight,
      ],
    );
  }
}

class DecisionButtonWidget extends StatelessWidget {
  const DecisionButtonWidget({
    super.key,
    required this.buttonText,
    required this.onPressed,
  });
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(
            Color.fromRGBO(0, 0, 0, 0.1),
          ),
        ),
      ),
    );
  }
}

class TitleWithDetailWidget extends StatelessWidget {
  const TitleWithDetailWidget(
      {super.key, required this.title, required this.details});
  final String title;
  final String details;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            color: Color.fromRGBO(0, 0, 0, 0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        kheight,
        Text(details,
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
            )),
        kheight,
      ],
    );
  }
}
