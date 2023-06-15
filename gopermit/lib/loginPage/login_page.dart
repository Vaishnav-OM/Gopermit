import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gop2/landingPage/body.dart';
import 'package:gop2/newPermission/components/background.dart';
import 'package:gop2/principalSide/principal_side_permission_screen.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  Future<void> _login(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    } catch (e) {
      // Handle login error
      // ignore: avoid_print
      print('Login error: $e');
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Error'),
          content: const Text('An error occurred during login.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }

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
                                _login(context);
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(233, 233, 233, 1)),
                              ),
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

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();
  Future<void> signInWIthEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
