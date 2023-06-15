import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:gop2/newPermission/components/body.dart';
import '../size_config.dart';

class newPermission extends StatefulWidget {
  const newPermission({super.key});

  @override
  State<newPermission> createState() => __newPermissionState();
}

class __newPermissionState extends State<newPermission> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Body(),
    );
    return const Placeholder();
  }
}
