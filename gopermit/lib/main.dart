import 'package:flutter/material.dart';
import 'newPermission/new_permission.dart';
import 'package:gopermit/loginPage/login_page.dart';
import 'principalSide/principal_side_permission_screen.dart';
import 'landingPage/body.dart';
import 'userDashboard/body.dart';
import 'scheduledEvents/body.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
