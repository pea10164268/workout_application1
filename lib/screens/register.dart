import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
          color: Colors.white,
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                Text(
                  "Register your account!\n",
                  style: GoogleFonts.arvo(
                    textStyle: Theme.of(context).textTheme.headline5,
                    color: Colors.black,
                  ),
                ),
              Expanded(
                child: Form(
                    child: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration:
                            const InputDecoration(labelText: 'Email Address *'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter an email address.';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration:
                            const InputDecoration(labelText: 'Password *'),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton.icon(
                            onPressed: () {
                            },
                            icon: const Icon(
                              Icons.login_outlined,
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
                        ]
                    )
                ),
              ),
                Text(
                  "Already have an account?",
                  style: GoogleFonts.arvo(
                    textStyle: Theme.of(context).textTheme.headline6,
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
                )
              )

            ]
          ),
        )
    );
  }
}
