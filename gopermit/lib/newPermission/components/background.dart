import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:gop2/size_config.dart';

class background extends StatelessWidget {
  const background({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.60,
              width: double.infinity,
              color: Colors.black,
              // child: Image.asset(
              //   "assets/images/bg_design.png",
              //   fit: BoxFit.fill,
              // ),
            ),
            Container(
              height: size.height * 0.40,
              width: double.infinity,
              color: Color.fromRGBO(0, 0, 0, 0.1),
            )
          ],
        ),
      ),
    );
    return const Placeholder();
  }
}
