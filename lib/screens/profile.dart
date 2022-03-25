import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "Profile Screen",
              style: GoogleFonts.arvo(
                textStyle: const TextStyle(fontSize: 20),
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0.0,
            centerTitle: true,
            actions: <Widget>[
              TextButton.icon(
                onPressed: () async {
                  await signOut();
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.black,
                ),
                label: Text(
                  "Log Out",
                  style: GoogleFonts.arvo(
                      textStyle: const TextStyle(fontSize: 14),
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ]),
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.white,
            padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[])));
  }

  Future signOut() async {
    return await _auth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false));
  }
}
