import 'package:flutter/material.dart';
import 'package:workout_application1/screens/profile.dart';
import 'package:workout_application1/screens/settings.dart';
import 'package:workout_application1/screens/workout/workout.dart';

class TabsScreen extends StatefulWidget {
      const TabsScreen({Key? key}) : super(key: key);

      @override
      State<TabsScreen> createState() => _TabsScreenState();
    }
    class _TabsScreenState extends State<TabsScreen> {
      final List<Map<String, Widget>> pages = [
        {
          'page': const Workout(),
        },
        {
          'page': const ProfileScreen(),
        },
        {
          'page': const Settings(),
        }
      ];
      int selectedPageIndex = 1;

      void selectPage(int index) {
        setState(() {
          selectedPageIndex = index;
        });
      }
      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: pages[selectedPageIndex]['page'],
          bottomNavigationBar: BottomNavigationBar(
            onTap: selectPage,
            backgroundColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            currentIndex: selectedPageIndex,
            items: [
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.fitness_center),
                label: 'Workouts',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                backgroundColor: Theme.of(context).primaryColor,
                icon: const Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          )
        );
      }
    }
