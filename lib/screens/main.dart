import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_application1/screens/register.dart';

import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: (MediaQuery.of(context).size.width),
        height: (MediaQuery.of(context).size.height),
        color: Colors.white,
        padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                  children: <Widget>[
                Text(
                  "Welcome!\n",
                  style: GoogleFonts.arvo(
                    textStyle: Theme.of(context).textTheme.headline4,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Do you have an account with us?",
                  style: GoogleFonts.arvo(
                    textStyle: Theme.of(context).textTheme.headline5,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ]),
              const SizedBox(height: 20),
              Column(children: <Widget>[
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Login()));
                    },
                    icon: Icon(
                      Icons.email,
                      color: Colors.white,
                    ),
                    label: Text("Sign in with email",
                      style: GoogleFonts.arvo(
                        textStyle: Theme.of(context).textTheme.headline6,
                        color: Colors.white,
                      ),
                    ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
                Text(
                  "\nOr\n",
                  style: GoogleFonts.arvo(
                    textStyle: Theme.of(context).textTheme.headline6,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Register()));
                  },
                  icon: const Icon(
                    Icons.how_to_reg,
                    color: Colors.white,
                  ),
                  label: Text("Sign up",
                    style: GoogleFonts.arvo(
                      textStyle: Theme.of(context).textTheme.headline6,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.black),
                  ),
                ),
              ]),
            ],
          ),
        ),
    );
  }
}
