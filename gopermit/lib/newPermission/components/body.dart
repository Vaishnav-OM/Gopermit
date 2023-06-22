import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gop2/scheduledEvents/body.dart';
import '../../services/event_json.dart';
import '/services/addevent.dart';
//import 'package:gopermit/services/allevent_json.dart';
//import 'package:gopermit/services/event_json.dart';
import '/size_config.dart';
import 'background.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  Future<void> addEventFromFields(
      TextEditingController eventNameController,
      TextEditingController organizingSocietyController,
      TextEditingController eventLocationController,
      TextEditingController eventDescriptionController,
      TextEditingController posterImageUrlController,
      TextEditingController pointOfContactController,
      TextEditingController pointOfContactPhoneController,
      DateTime? scheduledDate,
      String selectedstartTime,
      String selectedendTime,
      String imageUrl,
      String uid) async {
    String eventName = eventNameController.text;
    String organizingSociety = organizingSocietyController.text;
    String eventLocation = eventLocationController.text;
    String eventDescription = eventDescriptionController.text;
    // String posterImageUrl = posterImageUrlController.text;
    String pointOfContact = pointOfContactController.text;
    String pointOfContactPhone = pointOfContactPhoneController.text;
    DateTime scheduledEventDate = scheduledDate!.toLocal();
    String startTime = selectedstartTime;
    String endTime = selectedendTime;
    String uid = FirebaseAuth.instance.currentUser!.uid;
    _imageUrl = (await uploadImageToFirebaseStorage(_imageFile.path))!;
    print(_imageUrl);
//DateTime scheduledDate =
// startTime: startTime,
//         endTime: endTime,

// ... retrieve values from other text controllers for remaining fields
    addEvent(Eventonperm(
        eventName: eventName,
        organizingSociety: organizingSociety,
        eventLocation: eventLocation,
        scheduledDate: scheduledEventDate,
        startTime: startTime,
        endTime: endTime,
        eventDescription: eventDescription,
        posterImageUrl: _imageUrl,
        pointOfContact: pointOfContact,
        pointOfContactPhone: pointOfContactPhone,
        uid: uid));

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
  final TextEditingController _eventDateController = TextEditingController();
  late String selectedstartTime;
  late String selectedendTime;
  DateTime? selectedDate;

  Future<void> _selectEventDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _eventDateController.text =
            DateFormat('dd/MM/yyyy').format(selectedDate!);
        print(selectedDate);
      });
    }
  }

  Future<void> _selectstartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedstartTime = picked.format(context);
      });
    }
  }

  Future<void> _selectendTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedendTime = picked.format(context);
      });
    }
  }

//image picker
  late File _imageFile;
  late String _imageUrl;
  Future<void> _pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _imageFile = File(pickedImage.path);
      });
    }
  }

  Future<String?> uploadImageToFirebaseStorage(String imagePath) async {
    try {
      final firebase_storage.Reference storageRef =
          firebase_storage.FirebaseStorage.instance.ref().child('images');
      final firebase_storage.UploadTask uploadTask =
          storageRef.child(DateTime.now().toString()).putFile(File(imagePath));

      final firebase_storage.TaskSnapshot storageSnapshot =
          await uploadTask.whenComplete(() => null);

      final imageUrl = await storageSnapshot.ref.getDownloadURL();

      return imageUrl.toString();
    } catch (e) {
      print('Error uploading image: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    String imageUrl = '';
    String uid = FirebaseAuth.instance.currentUser!.uid;
    SizeConfig().init(context);
    // Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        background(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: const Text(
                'New Event',
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
                            controller: _eventDateController,
                            readOnly: true,
                            decoration: InputDecoration(
                              labelText: 'Scheduled Date',
                              suffixIcon: IconButton(
                                onPressed: () => _selectEventDate(context),
                                icon: Icon(Icons.calendar_today),
                              ),
                            ),
                          ),
                          kheight,
                          Row(
                            children: [
                              TitleWithDetailWidget(title: "Start Time"),
                              const SizedBox(width: 25),
                              TitleWithDetailWidget(title: "End Time")
                            ],
                          ),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  _selectstartTime(context);
                                },
                                child: Text('Select Start Time'),
                              ),
                              const SizedBox(width: 25),
                              ElevatedButton(
                                onPressed: () {
                                  _selectendTime(context);
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
                          ElevatedButton(
                            onPressed: () async {
                              _pickImageFromGallery();
                            },
                            child: const Text('Upload Image'),
                          ),
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
                                    pointOfContactPhoneController,
                                    selectedDate,
                                    selectedendTime,
                                    selectedstartTime,
                                    uid,
                                    imageUrl);
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
  const EventTextBox({required this.controller});

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
