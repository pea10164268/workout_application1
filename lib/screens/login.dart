import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workout_application1/screens/profile.dart';
import 'package:workout_application1/screens/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static Future<User?> signInWithEmailAndPassword ({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try{
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e){
      if(e.code == "user-not-found") {
        print("No user found with that email.");
      }
    }
    return user;
  }

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                      "Sign in to your account!",
                      style: GoogleFonts.arvo(
                  textStyle: Theme.of(context).textTheme.headline5,
              color: Colors.black,
                      ),
                  ),
                  Expanded(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            controller: _email,
                            maxLines: 1,
                            keyboardType: TextInputType.emailAddress,
                            autofocus: false,
                            decoration:
                            const InputDecoration(
                              hintText: 'Email',
                              icon: Icon(
                                Icons.mail,
                                color: Colors.black,
                              )
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email address.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _password,
                            obscureText: true,
                            decoration:
                            const InputDecoration(
                                hintText: 'Password',
                                icon: Icon(
                                  Icons.password,
                                  color: Colors.black,
                                )
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
                              User? user = await signInWithEmailAndPassword (
                                email: _email.text,
                                password: _password.text,
                                context: context,
                              );
                              print(user);
                              if(user != null) {
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => const ProfileScreen()));
                              }
                            },
                            icon: const Icon(
                              Icons.login_outlined,
                              color: Colors.white,
                            ),
                            label: Text("Sign in",
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
                        ]
                      )
                    ),
                  ),
                  Text(
                    "Don't have an account?",
                    style: GoogleFonts.arvo(
                      textStyle: Theme.of(context).textTheme.headline6,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Register()));
                      },
                      child: Text(
                        "Sign up",
                        style: GoogleFonts.arvo(
                          textStyle: Theme.of(context).textTheme.headline6,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationThickness: 2,
                        ),
                      )),
              ]

        ),
          ),
    );
  }
}
