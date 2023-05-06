import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gopermit/size_config.dart';
import 'background.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

const kheight = SizedBox(
  height: 15,
);

const kwidth = SizedBox(
  width: 50,
);

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        const background(),
        CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              title: Text(
                'New Event',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              leading: Icon(
                Icons.arrow_back,
                color: Colors.white,
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const TitleWithDetailWidget(title: 'Event Name'),
                          const EventTextBox(),
                          const TitleWithDetailWidget(
                              title: "Organizing Society"),
                          const EventTextBox(),
                          const TitleWithDetailWidget(
                              title: "Event Location/ Utility Centre "),
                          const EventTextBox(),
                          const TitleWithDetailWidget(title: "Scheduled Dates"),
                          Container(
                            height: 200,
                            width: 250,
                            decoration: BoxDecoration(border: Border.all()),
                          ),
                          kheight,
                          Row(
                            children: [
                              const TitleWithDetailWidget(title: "Start Time"),
                              kwidth,
                              const TitleWithDetailWidget(title: "End Time")
                            ],
                          ),
                          Row(
                            children: [
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white70),
                                ),
                              ),
                              const SizedBox(width: 25),
                              SizedBox(
                                height: 40,
                                width: 90,
                                child: TextField(
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      filled: true,
                                      fillColor: Colors.white70),
                                ),
                              ),
                            ],
                          ),
                          kheight,
                          const TitleWithDetailWidget(
                              title: "Event Description"),
                          Column(
                            children: [
                              SizedBox(
                                height: 200,
                                child: TextField(
                                  maxLines: 20,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      filled: true,
                                      // hintStyle: TextStyle(
                                      //   color: Colors.grey[800],
                                      // ),
                                      // hintText: "ENter ",
                                      fillColor: Colors.white70),
                                ),
                              ),
                              kheight,
                            ],
                          ),
                          kheight,
                          const TitleWithDetailWidget(title: "Event Poster"),
                          const EventTextBox(),
                          const TitleWithDetailWidget(
                              title: "Point of Contact with Class"),
                          const EventTextBox(),
                          const TitleWithDetailWidget(title: "Phone Number"),
                          EventTextBox(),
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: const Size(120, 50),
                                  backgroundColor:
                                      Color.fromARGB(255, 209, 209, 209)),
                              onPressed: () {},
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  color: Color.fromRGBO(0, 0, 0, 1),
                                  fontSize: 17,
                                  // backgroundColor: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ))
          ],
        ),
      ],
    );
  }
}

class TitleWithDetailWidget extends StatelessWidget {
  const TitleWithDetailWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Color.fromRGBO(0, 0, 0, 1),
            fontWeight: FontWeight.w600,
          ),
        ),
        kheight,
      ],
    );
  }
}

class EventTextBox extends StatelessWidget {
  const EventTextBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                filled: true,
                // hintStyle: TextStyle(
                //   color: Colors.grey[800],
                // ),
                // hintText: "ENter ",
                fillColor: Colors.white70),
          ),
        ),
        kheight,
      ],
    );
  }
}
