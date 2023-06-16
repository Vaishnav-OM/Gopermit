//import 'package:auth/auth.dart';
import 'package:flutter/material.dart';
import 'package:gop2/landingPage/body.dart';
//import 'newPermission/new_permission.dart';
import 'package:gop2/loginPage/login_page.dart';
//import 'principalSide/principal_side_permission_screen.dart';
//import 'landingPage/body.dart';
//import 'userDashboard/body.dart';
//import 'scheduledEvents/body.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gop2/principalSide/principal_side_permission_screen.dart';
import 'approvedRequest/body.dart';
import 'firebase_options.dart';
import 'newPermission/new_permission.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final User? user = Auth().currentUser;
  Future<void> signOut() async {
    await Auth().signOut();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
