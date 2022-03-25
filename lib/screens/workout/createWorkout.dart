import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:date_time_picker/date_time_picker.dart';

class CreateWorkout extends StatefulWidget {
  const CreateWorkout({Key? key}) : super(key: key);

  @override
  State<CreateWorkout> createState() => _CreateWorkoutState();
}

class _CreateWorkoutState extends State<CreateWorkout> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController activity = TextEditingController();
  final TextEditingController duration = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(
            color: Colors.black,
          ),
          title: Text(
            "Create a Workout",
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
            padding: const EdgeInsets.all(32),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child: Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter an activity.';
                                  }
                                  return null;
                                },
                                controller: activity,
                                autofocus: false,
                                decoration: const InputDecoration(
                                  hintText: 'Workout',
                                ),
                                style: GoogleFonts.arvo(
                                  textStyle:
                                  Theme.of(context).textTheme.headline6,
                                  color: Colors.black,
                                ),
                              ),
                              DateTimePicker(
                                initialValue: DateTime.now().toString(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                                dateLabelText: 'Date',
                                style: GoogleFonts.arvo(
                                  textStyle:
                                  Theme.of(context).textTheme.headline6,
                                  color: Colors.black,
                                ),
                                onChanged: (val) => print(val),
                                validator: (val) {
                                  print(val);
                                  return null;
                                },
                                onSaved: (val) => print(val),
                              ),
                              const SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Create Workout",
                                  style: GoogleFonts.arvo(
                                    textStyle:
                                        Theme.of(context).textTheme.headline6,
                                    color: Colors.white,
                                  ),
                                ),
                                style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.black),
                                ),
                              ),
                            ],
                          )))
                ])));
  }
}

