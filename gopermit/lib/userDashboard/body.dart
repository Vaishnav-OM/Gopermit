import 'package:flutter/material.dart';
import 'package:gop2/loginPage/login_page.dart';
import 'package:gop2/newPermission/new_permission.dart';
import 'package:gop2/scheduledEvents/body.dart';
import 'package:gop2/approvedRequest/body.dart';
import 'package:gop2/rejectedRequest/body.dart';
import 'package:gop2/holdRequests/body.dart';
// import 'package:google_fonts/google_fonts.dart';
//import 'package:flutter/src/painting/image_resolution.dart';

// void main() {
//   runApp(const GoPermit());
// }

class UserDashBoard extends StatelessWidget {
  const UserDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Go Permit',
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
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
          Column(
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
                      value: '10',
                    ),
                    const SizedBox(
                      height: 8.0,
                      width: 8.0,
                    ),
                    _buildMetricBlock1(
                      title: 'Requests Approved',
                      value: '6',
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
                      value: '2',
                      context: context,
                    ),
                    const SizedBox(
                      height: 8.0,
                      width: 8.0,
                    ),
                    _buildMetricBlock3(
                      title: 'Requests on Hold',
                      value: '2',
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
              itemCount: 5,
              itemBuilder: (context, index) {
                return const EventOnHoldCard();
              },
            ),
          ),
        ],
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
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => appHold()),
          );
        },
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
}

class EventOnHoldCard extends StatelessWidget {
  const EventOnHoldCard({Key? key}) : super(key: key);

  get decoration => null;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => scheduledDetails(
                      eventId: AutofillHints.addressState,
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
