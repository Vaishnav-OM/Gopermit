import 'package:flutter/material.dart';

// void main() => runApp(MaterialApp(
//       home: MyApp(),
//     ));

class scheduledDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              title: const Text(
                'Introduction to IEEEXtreme',
                style: TextStyle(
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
                            SizedBox(
                              height: 10.0,
                            ),
                            Row(
                              children: [
                                Text('Guest',
                                    style: TextStyle(
                                        // fontFamily: 'Poppins-Medium',
                                        color: Colors.grey[900],
                                        // letterSpacing: 2.0,
                                        fontWeight: FontWeight.bold)),
                                SizedBox(width: 100),
                                Text('Vaishnav S',
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
                                Text('Room Number 409',
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
                            Text(
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed viverra sollicitudin odio, id dapibus turpis commodo nec. Donec sagittis ligula a quam commodo, vitae commodo felis blandit. Suspendisse maximus, purus ac lacinia mollis, nisi nulla molestie dui, ac dapibus arcu enim ut turpis. Maecenas vel turpis at eros malesuada ornare nec vitae elit. Suspendisse sit amet tellus semper, feugiat mi in, pretium nisl. Phasellus non turpis non nisl malesuada tristique. Aliquam ac purus vitae est pharetra viverra. Duis quis sapien sed mauris luctus tincidunt.',
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
  }
}
