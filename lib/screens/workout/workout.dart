import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Workout extends StatefulWidget {
  const Workout({Key? key}) : super(key: key);

  @override
  State<Workout> createState() => _WorkoutState();
}

class _WorkoutState extends State<Workout> {
  // text fields' controllers
  final TextEditingController _workoutController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  final CollectionReference _workouts =
      FirebaseFirestore.instance.collection('workouts');

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _workoutController.text = documentSnapshot['workout'];
      _durationController.text = documentSnapshot['duration'];
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return Padding(
              padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      controller: _workoutController,
                      decoration: const InputDecoration(labelText: 'Workout'),
                    ),
                    TextField(
                      controller: _durationController,
                      decoration: const InputDecoration(labelText: 'Duration'),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        child: Text(action == 'create' ? 'Create' : 'Update'),
                        onPressed: () async {
                          final String? workout = _workoutController.text;
                          final String? duration = _durationController.text;
                          if (workout != null && duration != null) {
                            if (action == 'create') {
                              await _workouts.add(
                                  {"workout": workout, "duration": duration});
                            }

                            if (action == 'update') {
                              await _workouts.doc(documentSnapshot!.id).update(
                                  {"workout": workout, "duration": duration});
                            }

                            _workoutController.text = '';
                            _durationController.text = '';

                            Navigator.of(context).pop();
                          }
                        })
                  ]));
        });
  }

  Future<void> _deleteWorkout(String workoutId) async {
    await _workouts.doc(workoutId).delete();

    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Workout deleted successfully')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using StreamBuilder to display all workouts from Firestore in real-time
      body: StreamBuilder(
        stream: _workouts.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: ListTile(
                    title: Text(documentSnapshot['workout']),
                    subtitle: Text(documentSnapshot['duration'].toString()),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteWorkout(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
