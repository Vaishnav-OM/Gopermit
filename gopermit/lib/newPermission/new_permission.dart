import 'package:flutter/material.dart';
//import 'package:flutter/src/widgets/framework.dart';
//import 'package:flutter/src/widgets/placeholder.dart';
// ignore: depend_on_referenced_packages
import '/newPermission/components/body.dart';
import '../size_config.dart';

// ignore: camel_case_types
class newPermission extends StatefulWidget {
  const newPermission({super.key});

  @override
  State<newPermission> createState() => __newPermissionState();
}

// ignore: camel_case_types
class __newPermissionState extends State<newPermission> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //Size size = MediaQuery.of(context).size;

    return const Scaffold(
      body: Body(),
    );
    //return const Placeholder();
  }
}
