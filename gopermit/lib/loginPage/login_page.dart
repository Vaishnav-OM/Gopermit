import 'package:flutter/material.dart';
import 'package:gopermit/landingPage/body.dart';
import 'package:gopermit/newPermission/components/background.dart';
import 'package:gopermit/principalSide/principal_side_permission_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const background(),
        CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              title: Text(
                'GoPermit',
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
              delegate: SliverChildListDelegate.fixed([
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Hello Again!',
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          kheight,
                          kheight,
                          TitleWithTextField(
                              text: 'Username', controller: usernameController),
                          TitleWithTextField(
                            text: 'Password',
                            controller: passwordController,
                            ispassword: true,
                          ),
                          kheight,
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(233, 233, 233, 1))),
                              child: const Text(
                                'LOGIN',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          kheight,
                          const Center(
                            child: Text('-OR-',
                                style: TextStyle(
                                  color: Color.fromARGB(46, 0, 0, 0),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                )),
                          ),
                          kheight,
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(233, 233, 233, 1))),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: const [
                                  // SizedBox(
                                  //   width: 38,
                                  //   height: 38,
                                  //   child: Image(
                                  //       image: AssetImage(
                                  //           'assets/images/google_logo.png')),
                                  // ),
                                  Text(
                                    'Login With Google',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ]),
            ),
          ],
        ),
      ],
    ));
  }
}

class TitleWithTextField extends StatelessWidget {
  TitleWithTextField({
    super.key,
    required this.text,
    required this.controller,
    this.ispassword = false,
  });
  final bool ispassword;
  final String text;
  final TextEditingController controller;
  final ValueNotifier<bool> passVisibleNotifier = ValueNotifier(false);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${text.toUpperCase()}:',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        kheight,
        ValueListenableBuilder(
            valueListenable: passVisibleNotifier,
            builder: (context, newBool, _) {
              return TextFormField(
                obscureText: !newBool,
                controller: controller,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(width: 1.5, color: Colors.black)),
                  suffixIcon: ispassword
                      ? GestureDetector(
                          child: newBool
                              ? const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                )
                              : const Icon(
                                  Icons.visibility_off,
                                  color: Colors.black,
                                ),
                          onTap: () {
                            passVisibleNotifier.value =
                                !passVisibleNotifier.value;
                            passVisibleNotifier.notifyListeners();
                          },
                        )
                      : const SizedBox(),
                ),
              );
            }),
        kheight,
      ],
    );
  }
}
