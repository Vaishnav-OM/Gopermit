// ignore: depend_on_referenced_packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gop2/landingPage/body.dart';
import 'package:gop2/userDashboard/body.dart';
import '../principaldash/main.dart';
import '/newPermission/components/background.dart';
import '/principalSide/principal_side_permission_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
      if (userCredential.user != null) {
        // User is authenticated, navigate to the user dashboard
        // ignore: use_build_context_synchronously
        final User user = userCredential.user!;
        final bool isAdmin = await _checkAdminPrivileges(user.uid);
        if (isAdmin) {
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const princDashBoard(), // Replace with your user dashboard screen
            ),
          );
        } else {
          User? user = FirebaseAuth.instance.currentUser;
          String? uid = user?.uid;
          print(uid);
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserDashBoard(uid: uid),
              // Replace with your user dashboard screen
            ),
          );
        }
      }
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

  /*
  Future<void> loginAdmin(BuildContext context) async {
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      if (userCredential.user != null) {
        // Check if the user is an admin
        final User user = userCredential.user!;
        final bool isAdmin = await _checkAdminPrivileges(user.uid);

        if (isAdmin) {
          // User is an admin, navigate to the admin dashboard
          // ignore: use_build_context_synchronously
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const princDashBoard(), // Replace with your admin dashboard screen
            ),
          );
        } else {
          // User is not an admin, display an error message
          // ignore: use_build_context_synchronously
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Admin Login Error'),
              content: const Text('You do not have admin privileges.'),
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
    } catch (e) {
      // Handle login error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Admin Login Error'),
          content: const Text('An error occurred during admin login.'),
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
  */
  Future<bool> _checkAdminPrivileges(String userId) async {
    // Implement your logic to check if the user has admin privileges.
    // This can involve querying your Firebase database or Firestore to verify the admin status of the user.
    // Return true if the user is an admin, otherwise return false.
    // Example implementation using Firestore:

    final DocumentSnapshot adminSnapshot =
        await FirebaseFirestore.instance.collection('admin').doc(userId).get();

    return adminSnapshot.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        const background(),
        CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              title: const Text(
                'GoPermit',
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
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
                          TextField(
                            controller: usernameController,
                            decoration:
                                const InputDecoration(hintText: 'Username'),
                          ),
                          TextField(
                            controller: passwordController,
                            decoration:
                                const InputDecoration(hintText: 'Password'),
                            obscureText: true,
                          ),
                          /*
                          TitleWithTextField(
                            text: 'Password',
                            controller: passwordController,
                            ispassword: true,
                          ),
                          */
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
                          /*
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
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const princDashBoard(), // Replace with your user dashboard screen
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                  elevation: MaterialStateProperty.all(0),
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color.fromRGBO(233, 233, 233, 1))),
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(
                                  //   width: 38,
                                  //   height: 38,
                                  //   child: Image(
                                  //       image: AssetImage(
                                  //           'assets/images/google_logo.png')),
                                  // ),
                                  Text(
                                    'Login as Admin',
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
                          
                          SizedBox(
                            width: double.infinity,
                            height: 45,
                            child: ElevatedButton(
                              onPressed: () {
                                loginAdmin(context);
                              },
                              style: ButtonStyle(
                                elevation: MaterialStateProperty.all(0),
                                backgroundColor: MaterialStateProperty.all(
                                    const Color.fromRGBO(233, 233, 233, 1)),
                              ),
                              child: const Text(
                                'Login as Admin',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          */
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

                            // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
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
