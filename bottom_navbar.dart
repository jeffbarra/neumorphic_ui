import 'package:drill_app/widgets/dialog_boxes/add_workout.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../pages/home.dart';
import '../pages/profile.dart';

class BottomNavBarView extends StatefulWidget {
  BottomNavBarView({Key? key}) : super(key: key);

  @override
  State<BottomNavBarView> createState() => _BottomNavBarViewState();
}

class _BottomNavBarViewState extends State<BottomNavBarView> {
// Text Controllers
  TextEditingController workoutController = TextEditingController();

// Current Index
  int currentIndex = 0;

// Button Push
  bool isButtonOnePressed = false;
  bool isButtonThreePressed = true;

  void onItemTapped(int index) {
    setState(() {
      // current index
      currentIndex = index;

      // button pressed toggle
      isButtonOnePressed = !isButtonOnePressed;
      isButtonThreePressed = !isButtonThreePressed;
    });
  }

// Current User
  final currentUser = FirebaseAuth.instance.currentUser!;

  List<Widget> widgetOption = [
    const HomePage(),
    const HomePage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: Container(
// Bottom Nav Bar
          child: BottomNavigationBar(
            backgroundColor: Colors.grey.shade900,
            onTap: onItemTapped,
            currentIndex: currentIndex,
            unselectedItemColor: Colors.grey.shade800,
            selectedItemColor: Colors.grey.shade600,
            type: BottomNavigationBarType.fixed,
            items: [
              // Home Icon
              BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.grey.shade900,
                        // Button Shadowing
                        boxShadow: [
                          // bottom right shadow is darker
                          isButtonOnePressed
                              ? const BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                  offset: Offset(5, 5),
                                )
                              : const BoxShadow(
                                  color: Colors.black,
                                  spreadRadius: 5,
                                  blurRadius: 15,
                                  offset: Offset(-5, -5)),

                          // top left shadow is lighter
                          isButtonOnePressed
                              ? BoxShadow(
                                  color: Colors.grey.shade800,
                                  offset: const Offset(-4, -4),
                                  blurRadius: 15,
                                  spreadRadius: 1)
                              : BoxShadow(
                                  color: Colors.grey.shade800,
                                  offset: Offset(4, 4),
                                  blurRadius: 15,
                                  spreadRadius: 1),
                        ],
                      ),
                      child: const Icon(
                        Icons.home_rounded,
                        size: 35,
                      ),
                    ),
                  ),
                  label: ''),

              // Add Event Icon
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade900,
                          boxShadow: [
                            // bottom right shadow is darker
                            const BoxShadow(
                              color: Colors.black,
                              spreadRadius: 5,
                              blurRadius: 15,
                              offset:
                                  Offset(5, 5), // changes position of shadow
                            ),

                            // top left shadow is lighter
                            BoxShadow(
                                color: Colors.grey.shade800,
                                offset: const Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: 1)
                          ],
                        ),
                        child: IconButton(
                          icon: Icon(Icons.add_rounded,
                              color: Colors.grey.shade800),
                          onPressed: () {
                            showDialog(
                                context: context,
                                // Add a New Workout Dialog Box
                                builder: (context) => AddWorkoutDialogBox());
                          },
                          color: Theme.of(context).primaryColor,
                          iconSize: 50,
                        ),
                      )),
                  label: ''),

              // Profile Icon
              BottomNavigationBarItem(
                  icon: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey.shade900,
                          boxShadow: [
                            // bottom right shadow is darker
                            isButtonThreePressed
                                ? const BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: Offset(
                                        5, 5), // changes position of shadow
                                  )
                                : const BoxShadow(
                                    color: Colors.black,
                                    spreadRadius: 5,
                                    blurRadius: 15,
                                    offset: Offset(-5, -5),
                                  ),

                            // top left shadow is lighter
                            isButtonThreePressed
                                ? BoxShadow(
                                    color: Colors.grey.shade800,
                                    offset: const Offset(-4, -4),
                                    blurRadius: 15,
                                    spreadRadius: 1)
                                : BoxShadow(
                                    color: Colors.grey.shade800,
                                    offset: Offset(4, 4),
                                    blurRadius: 15,
                                    spreadRadius: 1),
                          ],
                        ),
                        child: const Icon(
                          Icons.account_circle,
                          size: 35,
                        ),
                      )),
                  label: ''),
            ],
          ),
        ),

// Body
        body: widgetOption[currentIndex]);
  }
}
