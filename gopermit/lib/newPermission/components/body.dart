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
// import 'package:gopermit/size_config.dart';
// import 'background.dart';
// import '../../services/addevent.dart';
// import '../../services/event_json.dart';

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
//   final _formKey = GlobalKey<FormState>();

//   String eventName = '';
//   String organizingSociety = '';
//   String eventLocation = '';
//   DateTime scheduledDate = DateTime.now();
//   TimeOfDay startTime = TimeOfDay.now();
//   TimeOfDay endTime = TimeOfDay.now();
//   String eventDescription = '';
//   String pointOfContact = '';
//   String pointOfContactPhone = '';
//   String posterImageUrl = '';
//   bool isApproved = false;
//   void addEventtosubmit() {
//     if (_formKey.currentState?.validate() ?? false) {
//       // Create an Event object with the entered data
//       Eventonperm newEvent = Eventonperm(
//         eventName: eventName,
//         organizingSociety: organizingSociety,
//         eventLocation: eventLocation,
//         scheduledDate: scheduledDate,
//         startTime: startTime,
//         endTime: endTime,
//         eventDescription: eventDescription,
//         posterImageUrl: posterImageUrl,
//         pointOfContact: pointOfContact,
//         pointOfContactPhone: pointOfContactPhone,
//         isApproved: isApproved,
//       );

//       // Call the addEvent function to save the event to the backend
//       addEvent(newEvent);

//       // Clear the form fields

//       // Show a success message or navigate to another page
//       // ...
//     }
//   }

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
//                           EventTextBox(
//                             onChanged: (value) {
//                               setState(() {
//                                 eventName = value;
//                               });
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the event name';
//                               }
//                               return null;
//                             },
//                           ),
//                           const TitleWithDetailWidget(
//                               title: "Organizing Society"),
//                           EventTextBox(
//                             onChanged: (value) {
//                               setState(() {
//                                 organizingSociety = value;
//                               });
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the event name';
//                               }
//                               return null;
//                             },
//                           ),
//                           const TitleWithDetailWidget(
//                               title: "Event Location/ Utility Centre "),
//                           EventTextBox(
//                             onChanged: (value) {
//                               setState(() {
//                                 eventLocation = value;
//                               });
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the event name';
//                               }
//                               return null;
//                             },
//                           ),
//                           const TitleWithDetailWidget(title: "Scheduled Dates"),
//                           Container(
//                             height: 200,
//                             width: 250,
//                             decoration: BoxDecoration(border: Border.all()),
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
//                               SizedBox(
//                                 height: 40,
//                                 width: 90,
//                                 child: TextField(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       startTime = TimeOfDay.now();
//                                     });
//                                   },
//                                   // validator: (value) {
//                                   //   if (value == null || value.isEmpty) {
//                                   //     return 'Please enter the event name';
//                                   //   }
//                                   //   return null;
//                                   // },
//                                   decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.white70),
//                                 ),
//                               ),
//                               const SizedBox(width: 25),
//                               SizedBox(
//                                 height: 40,
//                                 width: 90,
//                                 child: TextField(
//                                   onChanged: (value) {
//                                     setState(() {
//                                       endTime = TimeOfDay.now();
//                                     });
//                                   },
//                                   decoration: InputDecoration(
//                                       border: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(5),
//                                       ),
//                                       filled: true,
//                                       fillColor: Colors.white70),
//                                 ),
//                               ),
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
//                                   onChanged: (value) {
//                                     setState(() {
//                                       eventDescription = value;
//                                     });
//                                   },
//                                   // validator: (value) {
//                                   //   if (value == null || value.isEmpty) {
//                                   //     return 'Please enter the event name';
//                                   //   }
//                                   //   return null;
//                                   // },
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
//                           EventTextBox(
//                             onChanged: (value) {
//                               setState(() {
//                                 posterImageUrl = value;
//                               });
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the event name';
//                               }
//                               return null;
//                             },
//                           ),
//                           const TitleWithDetailWidget(
//                               title: "Point of Contact with Class"),
//                           EventTextBox(
//                             onChanged: (value) {
//                               setState(() {
//                                 pointOfContact = value;
//                               });
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the event name';
//                               }
//                               return null;
//                             },
//                           ),
//                           const TitleWithDetailWidget(title: "Phone Number"),
//                           EventTextBox(
//                             onChanged: (value) {
//                               setState(() {
//                                 pointOfContactPhone = value;
//                               });
//                             },
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Please enter the event name';
//                               }
//                               return null;
//                             },
//                           ),
//                           Center(
//                             child: TextButton(
//                               style: TextButton.styleFrom(
//                                   fixedSize: const Size(120, 50),
//                                   backgroundColor:
//                                       Color.fromARGB(255, 209, 209, 209)),
//                               onPressed: () {
//                                 addEventtosubmit();
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
//   final ValueChanged<String>? onChanged;
//   final FormFieldValidator<String>? validator;
//   const EventTextBox({
//     Key? key,
//     this.onChanged,
//     this.validator,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         SizedBox(
//           height: 48,
//           child: TextField(
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
