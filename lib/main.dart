import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'screens/login.dart';
import 'screens/register.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot){
          if(snapshot.connectionState == ConnectionState.done) {
            return const HomeScreen();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
                icon: const Icon(
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
