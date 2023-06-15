import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gop2/services/addevent.dart';
import 'package:gop2/services/allevent_json.dart';
import 'package:gop2/services/event_json.dart';
import 'package:gop2/size_config.dart';
import 'background.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

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

// TimeOfDay? selectedTime;
// DateTime? selectedDate = DateTime.now();

class _BodyState extends State<Body> {
  void addEventFromFields(
      TextEditingController eventNameController,
      TextEditingController organizingSocietyController,
      TextEditingController eventLocationController,
      TextEditingController eventDescriptionController,
      TextEditingController posterImageUrlController,
      TextEditingController pointOfContactController,
      TextEditingController pointOfContactPhoneController) {
    String eventName = eventNameController.text;
    String organizingSociety = organizingSocietyController.text;
    String eventLocation = eventLocationController.text;
    String eventDescription = eventDescriptionController.text;

    // String scheduledDate = selectedDate;

    String posterImageUrl = posterImageUrlController.text;
    String pointOfContact = pointOfContactController.text;
    String pointOfContactPhone = pointOfContactPhoneController.text;

//DateTime scheduledDate =
// startTime: startTime,
//         endTime: endTime,

// ... retrieve values from other text controllers for remaining fields
    // addEvent(Eventonperm(
    //     eventName: eventName,
    //     organizingSociety: organizingSociety,
    //     eventLocation: eventLocation,
    //     // scheduledDate: scheduledDate,
    //     startTime: TimeOfDay.now(),
    //     endTime: TimeOfDay.now(),
    //     eventDescription: eventDescription,
    //     posterImageUrl: posterImageUrl,
    //     pointOfContact: pointOfContact,
    //     pointOfContactPhone: pointOfContactPhone));

// Call the addEvent function to add the event to Firestore
  }

  final TextEditingController eventNameController = TextEditingController();
  final TextEditingController organizingSocietyController =
      TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventDescriptionController =
      TextEditingController();
  final TextEditingController posterImageUrlController =
      TextEditingController();
  final TextEditingController pointOfContactController =
      TextEditingController();
  final TextEditingController pointOfContactPhoneController =
      TextEditingController();

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        // selectedTime = picked;
      });
    }
  }

  // Save the scheduledDateTime to Firebase or use it as needed

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
                          EventTextBox(controller: eventNameController),
                          const TitleWithDetailWidget(
                              title: "Organizing Society"),
                          EventTextBox(
                            controller: organizingSocietyController,
                          ),
                          const TitleWithDetailWidget(
                              title: "Event Location/ Utility Centre "),
                          EventTextBox(
                            controller: eventLocationController,
                          ),
                          const TitleWithDetailWidget(title: "Scheduled Dates"),
                          TextFormField(
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Scheduled Date',
                              suffixIcon: IconButton(
                                onPressed: () => _selectDate(context),
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
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
                              ElevatedButton(
                                onPressed: () {
                                  _selectTime(context);
                                },
                                child: Text('Select Start Time'),
                              ),
                              const SizedBox(width: 25),
                              ElevatedButton(
                                onPressed: () {
                                  _selectTime(context);
                                },
                                child: Text('Select End Time'),
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
                                  controller: eventDescriptionController,
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
                          EventTextBox(controller: posterImageUrlController),
                          const TitleWithDetailWidget(
                              title: "Point of Contact with Class"),
                          EventTextBox(controller: pointOfContactController),
                          const TitleWithDetailWidget(title: "Phone Number"),
                          EventTextBox(
                              controller: pointOfContactPhoneController),
                          Center(
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  fixedSize: const Size(120, 50),
                                  backgroundColor:
                                      Color.fromARGB(255, 209, 209, 209)),
                              onPressed: () {
                                addEventFromFields(
                                    eventNameController,
                                    organizingSocietyController,
                                    eventLocationController,
                                    eventDescriptionController,
                                    posterImageUrlController,
                                    pointOfContactController,
                                    pointOfContactPhoneController);
                              },
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
  final TextEditingController controller;
  EventTextBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 48,
          child: TextField(
            controller: controller,
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

// import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
// import 'package:gop2/services/addevent.dart';
// import 'package:gop2/services/allevent_json.dart';
// import 'package:gop2/services/event_json.dart';
// import 'package:gop2/size_config.dart';
// import 'background.dart';
// // import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

// class Body extends StatefulWidget {
//   const Body({super.key});

//   @override
//   State<Body> createState() => _BodyState();
// }

// const kheight = SizedBox(
//   height: 15,
// );

// const kwidth = SizedBox(
//   width: 50,
// );

// class _BodyState extends State<Body> {
//   void addEventFromFields(
//       TextEditingController eventNameController,
//       TextEditingController organizingSocietyController,
//       TextEditingController eventLocationController,
//       TextEditingController eventDescriptionController,
//       TextEditingController dateController,
//       TextEditingController startController,
//       TextEditingController endController,
//       TextEditingController posterImageUrlController,
//       TextEditingController pointOfContactController,
//       TextEditingController pointOfContactPhoneController) {
//     String eventName = eventNameController.text;
//     String organizingSociety = organizingSocietyController.text;
//     String eventLocation = eventLocationController.text;
//     String eventDescription = eventDescriptionController.text;

//     String startformattedTime =
//         startselectedTime != null ? startselectedTime!.format(context) : '';
//     String startTime = startformattedTime;

//     String endformattedTime =
//         startselectedTime != null ? startselectedTime!.format(context) : '';
//     String endtime = endformattedTime;

//     String posterImageUrl = posterImageUrlController.text;
//     String pointOfContact = pointOfContactController.text;
//     String pointOfContactPhone = pointOfContactPhoneController.text;

// //DateTime scheduledDate =
// // startTime: startTime,
// //         endTime: endTime,

// // ... retrieve values from other text controllers for remaining fields
//     addEvent(Eventonperm(
//         eventName: eventName,
//         organizingSociety: organizingSociety,
//         eventLocation: eventLocation,
//         scheduledDate: startTime,
//         startTime: startTime,
//         endTime: endtime,
//         eventDescription: eventDescription,
//         posterImageUrl: posterImageUrl,
//         pointOfContact: pointOfContact,
//         pointOfContactPhone: pointOfContactPhone));

// // Call the addEvent function to add the event to Firestore
//   }

//   final TextEditingController eventNameController = TextEditingController();
//   final TextEditingController organizingSocietyController =
//       TextEditingController();
//   final TextEditingController eventLocationController = TextEditingController();
//   final TextEditingController eventDescriptionController =
//       TextEditingController();
//   final TextEditingController posterImageUrlController =
//       TextEditingController();
//   final TextEditingController pointOfContactController =
//       TextEditingController();

//   final TextEditingController dateController = TextEditingController();
//   final TextEditingController startController = TextEditingController();
//   final TextEditingController endController = TextEditingController();
//   final TextEditingController pointOfContactPhoneController =
//       TextEditingController();

//   DateTime? selectedDate;

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: selectedDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2100),
//     );
//     if (pickedDate != null && pickedDate != selectedDate) {
//       setState(() {
//         selectedDate = pickedDate;
//       });
//     }
//   }

//   TimeOfDay? startselectedTime;

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: startselectedTime ?? TimeOfDay.now(),
//     );
//     if (pickedTime != null && pickedTime != startselectedTime) {
//       setState(() {
//         startselectedTime = pickedTime;
//       });
//     }
//   }

//   TimeOfDay? endselectedTime;

//   Future<void> _endselectTime(BuildContext context) async {
//     final TimeOfDay? pickedTime = await showTimePicker(
//       context: context,
//       initialTime: startselectedTime ?? TimeOfDay.now(),
//     );
//     if (pickedTime != null && pickedTime != startselectedTime) {
//       setState(() {
//         startselectedTime = pickedTime;
//       });
//     }
//   }

//   // Save the scheduledDateTime to Firebase or use it as needed

//   @override
//   Widget build(BuildContext context) {
//     SizeConfig().init(context);
//     Size size = MediaQuery.of(context).size;
//     return Stack(
//       children: [
//         const background(),
//         CustomScrollView(
//           slivers: <Widget>[
//             const SliverAppBar(
//               title: Text(
//                 'New Event',
//                 style: TextStyle(color: Colors.white, fontSize: 28),
//               ),
//               leading: Icon(
//                 Icons.arrow_back,
//                 color: Colors.white,
//               ),
//               pinned: false,
//               snap: false,
//               floating: false,
//               backgroundColor: Colors.transparent,
//               centerTitle: true,
//             ),
//             SliverList(
//                 delegate: SliverChildListDelegate.fixed(
//               [
//                 Padding(
//                   padding:
//                       const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(18.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           const TitleWithDetailWidget(title: 'Event Name'),
//                           EventTextBox(controller: eventNameController),
//                           const TitleWithDetailWidget(
//                               title: "Organizing Society"),
//                           EventTextBox(
//                             controller: organizingSocietyController,
//                           ),
//                           const TitleWithDetailWidget(
//                               title: "Event Location/ Utility Centre "),
//                           EventTextBox(
//                             controller: eventLocationController,
//                           ),
//                           const TitleWithDetailWidget(title: "Scheduled Dates"),
//                           TextField(
//                             readOnly: true,
//                             decoration: InputDecoration(
//                               labelText: 'Scheduled Date',
//                               suffixIcon: IconButton(
//                                 onPressed: () => _selectDate(context),
//                                 icon: Icon(Icons.calendar_today),
//                               ),
//                             ),
//                           ),
//                           kheight,
//                           Row(
//                             children: [
//                               const TitleWithDetailWidget(title: "Start Time"),
//                               kwidth,
//                               const TitleWithDetailWidget(title: "End Time")
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               TextField(
//                                 readOnly: true,
//                                 controller: startController,
//                                 decoration: InputDecoration(
//                                   labelText: 'Start Time',
//                                   suffixIcon: IconButton(
//                                     onPressed: () => _selectTime(context),
//                                     icon: Icon(Icons.access_time),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 25),
//                               // TextFormField(
//                               //   readOnly: true,
//                               //   controller: endController,
//                               //   decoration: InputDecoration(
//                               //     labelText: 'End Time',
//                               //     suffixIcon: IconButton(
//                               //       onPressed: () => _endselectTime(context),
//                               //       icon: Icon(Icons.access_time),
//                               //     ),
//                               //   ),
//                               // ),
//                             ],
//                           ),
//                           kheight,
//                           const TitleWithDetailWidget(
//                               title: "Event Description"),
//                           Column(
//                             children: [
//                               SizedBox(
//                                 height: 200,
//                                 child: TextField(
//                                   controller: eventDescriptionController,
//                                   maxLines: 20,
//                                   decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                         borderRadius:
//                                             BorderRadius.circular(10.0),
//                                       ),
//                                       filled: true,
//                                       // hintStyle: TextStyle(
//                                       //   color: Colors.grey[800],
//                                       // ),
//                                       // hintText: "ENter ",
//                                       fillColor: Colors.white70),
//                                 ),
//                               ),
//                               kheight,
//                             ],
//                           ),
//                           kheight,
//                           const TitleWithDetailWidget(title: "Event Poster"),
//                           EventTextBox(controller: posterImageUrlController),
//                           const TitleWithDetailWidget(
//                               title: "Point of Contact with Class"),
//                           EventTextBox(controller: pointOfContactController),
//                           const TitleWithDetailWidget(title: "Phone Number"),
//                           EventTextBox(
//                               controller: pointOfContactPhoneController),
//                           Center(
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                   fixedSize: const Size(120, 50),
//                                   backgroundColor:
//                                       Color.fromARGB(255, 209, 209, 209)),
//                               onPressed: () {
//                                 addEventFromFields(
//                                     eventNameController,
//                                     organizingSocietyController,
//                                     eventLocationController,
//                                     eventDescriptionController,
//                                     dateController,
//                                     startController,
//                                     endController,
//                                     posterImageUrlController,
//                                     pointOfContactController,
//                                     pointOfContactPhoneController);
//                               },
//                               child: Text(
//                                 "Submit",
//                                 style: TextStyle(
//                                   color: Color.fromRGBO(0, 0, 0, 1),
//                                   fontSize: 17,
//                                   // backgroundColor: Colors.grey,
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ))
//           ],
//         ),
//       ],
//     );
//   }
// }

// class TitleWithDetailWidget extends StatelessWidget {
//   const TitleWithDetailWidget({super.key, required this.title});
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           title,
//           style: const TextStyle(
//             fontSize: 16,
//             color: Color.fromRGBO(0, 0, 0, 1),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         kheight,
//       ],
//     );
//   }
// }

// class EventTextBox extends StatelessWidget {
//   final TextEditingController controller;
//   EventTextBox({required this.controller});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 48,
//           child: TextField(
//             controller: controller,
//             decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 filled: true,
//                 // hintStyle: TextStyle(
//                 //   color: Colors.grey[800],
//                 // ),
//                 // hintText: "ENter ",
//                 fillColor: Colors.white70),
//           ),
//         ),
//         kheight,
//       ],
//     );
//   }
// }

