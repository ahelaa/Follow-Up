import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:followup/screens/ParentHome.dart';
import 'package:followup/screens/ParentProfile.dart';
import 'package:followup/screens/TeacherHome.dart';
import 'package:followup/screens/TeacherProfile.dart';
import 'package:followup/screens/homepage.dart';
import 'package:followup/screens/profile.dart';
import 'package:followup/screens/settings.dart';
import 'package:followup/screens/splash.dart';
import 'package:followup/firebase_options.dart';
import 'package:followup/screens/student_list_screen.dart';
import 'package:followup/screens/teacher.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        home: numberone(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class navigationbarforstudent extends StatefulWidget {
  const navigationbarforstudent({super.key});

  @override
  State<navigationbarforstudent> createState() => _navigationbarState();
}

class _navigationbarState extends State<navigationbarforstudent> {
  int currentindex = 0;
  final screens = [
    homepage(),
    TeacherListScreen(),
    ProfilePage(),
    settingspage(),

    //hankhliha settings
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xff235391),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            iconSize: 30,
            currentIndex: currentindex,
            onTap: (index) => setState(() => currentindex = index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'chat',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'profile',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'settings',
                  backgroundColor: Colors.blue),
            ]),
      );
}

class navigationbarforteacher extends StatefulWidget {
  const navigationbarforteacher({super.key});

  @override
  State<navigationbarforteacher> createState() =>
      _navigationbarforteacherState();
}

class _navigationbarforteacherState extends State<navigationbarforteacher> {
  int currentindex = 0;
  final screens = [
    TeacherHome(),
    TeacherChatScreen(),
    TeacherProfile(),
    settingspage(), //hankhliha settings
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xff235391),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            iconSize: 30,
            currentIndex: currentindex,
            onTap: (index) => setState(() => currentindex = index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'chat',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'profile',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'settings',
                  backgroundColor: Colors.blue),
            ]),
      );
}

class navigationbarforparent extends StatefulWidget {
  const navigationbarforparent({super.key});

  @override
  State<navigationbarforparent> createState() => _navigationbarforparentState();
}

class _navigationbarforparentState extends State<navigationbarforparent> {
  int currentindex = 0;
  final screens = [
    ParentHome(),
    TeacherListScreen(),
    ParentProfile(),
    settingspage(), //hankhliha settings
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: screens[currentindex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Color(0xff235391),
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            iconSize: 30,
            currentIndex: currentindex,
            onTap: (index) => setState(() => currentindex = index),
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'home',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.chat),
                  label: 'chat',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'profile',
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'settings',
                  backgroundColor: Colors.blue),
            ]),
      );
}
