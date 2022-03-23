import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _email = TextEditingController();
  late TextEditingController _password = TextEditingController();

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
                  "Register your account!",
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
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Processing Data')),
                                );
                              }
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
