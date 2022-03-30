import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workout_application1/screens/home/registration/registerSuccess.dart';

import '../../profile.dart';
import '../login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email;
  late TextEditingController _password;
  late TextEditingController _firstName;
  late TextEditingController _lastName;
  late TextEditingController _conPassword;
  final _auth = FirebaseAuth.instance;

  @override
  initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _password = TextEditingController();
    _conPassword = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _firstName.dispose();
    _lastName.dispose();
    _conPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const BackButton(
          color: Colors.black,
        ),
        title: Text(
          "Register your account",
          style: GoogleFonts.arvo(
            textStyle: const TextStyle(fontSize: 20),
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        padding: const EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: Form(
                    key: _formKey,
                    child: Column(children: <Widget>[
                      TextFormField(
                        controller: _firstName,
                        maxLines: 1,
                        autofocus: false,
                        decoration: const InputDecoration(
                          hintText: 'First Name',
                        ),
                        style: GoogleFonts.arvo(
                          textStyle: Theme.of(context).textTheme.headline6,
                          color: Colors.black,
                        ),
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your first name.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _lastName,
                        maxLines: 1,
                        autofocus: false,
                        decoration: const InputDecoration(
                          hintText: 'Last Name',
                        ),
                        textInputAction: TextInputAction.next,
                        style: GoogleFonts.arvo(
                          textStyle: Theme.of(context).textTheme.headline6,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your last name.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _email,
                        maxLines: 1,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        autofocus: false,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          icon: Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                        ),
                        style: GoogleFonts.arvo(
                          textStyle: Theme.of(context).textTheme.headline6,
                          color: Colors.black,
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
                        textInputAction: TextInputAction.next,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Password',
                            icon: Icon(
                              Icons.password,
                              color: Colors.black,
                            )),
                        style: GoogleFonts.arvo(
                          textStyle: Theme.of(context).textTheme.headline6,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password.';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _conPassword,
                        obscureText: true,
                        decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            icon: Icon(
                              Icons.password,
                              color: Colors.black,
                            )),
                        style: GoogleFonts.arvo(
                          textStyle: Theme.of(context).textTheme.headline6,
                          color: Colors.black,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your confirmation password.';
                          } else if (_conPassword.text != _password.text) {
                            return 'The password and confirmation password do not match.';
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
                            try {
                              final newUser =
                                  await _auth.createUserWithEmailAndPassword(
                                      email: _email.text,
                                      password: _password.text);
                              if (newUser != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const RegisterSuccess()));
                              }
                            } catch (e) {
                              print(e);
                            }
                          }
                        },
                        icon: const Icon(
                          Icons.how_to_reg,
                          color: Colors.white,
                        ),
                        label: Text(
                          "Sign up",
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
                    ])),
              ),
              Text(
                "Already have an account?",
                style: GoogleFonts.arvo(
                  textStyle: const TextStyle(fontSize: 16),
                  color: Colors.black,
                ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  child: Text(
                    "Sign in",
                    style: GoogleFonts.arvo(
                      textStyle: Theme.of(context).textTheme.headline6,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      decorationThickness: 2,
                    ),
                  ))
            ]),
      ),
    );
  }
}
