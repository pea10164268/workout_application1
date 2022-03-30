import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:workout_application1/screens/workout/workout.dart';

import 'activity/createActivity.dart';
import 'home/main.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
          appBar: AppBar(
              title: Text(
                "Profile Screen",
                style: GoogleFonts.arvo(
                  textStyle: const TextStyle(fontSize: 20),
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
              bottom: TabBar(
                tabs: <Widget> [
                  Tab(
                    child: TextButton(
                      child: Text(
                        "Workouts",
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(fontSize: 16),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                          onPressed: () {

                          },
                    ),
                  ),
                  Tab(
                    child: TextButton(
                      child: Text(
                          "Activities",
                        style: GoogleFonts.arvo(
                          textStyle: const TextStyle(fontSize: 16),
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: () {},
                    ),
                  )
                ]
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
              ],
          ),
        body: const TabBarView(
          children: <Widget> [
            Workout(),
            CreateActivity()
          ],
        )
      ),
);
  }

  Future signOut() async {
    return await _auth.signOut().then((value) => Navigator.of(context)
        .pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomeScreen()),
            (route) => false));
  }
}
