import 'package:flutter/material.dart';
import 'package:followup/screens/AdminLogin.dart';
import 'package:followup/screens/ParentLoginScreen.dart';
import 'package:followup/screens/StudentLoginScreen.dart';
import 'package:followup/screens/TeacherLoginScreen.dart';

class numberone extends StatelessWidget {
  const numberone({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff235391),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          //Image(
          //image: AssetImage('assets/images/backgroundd.jpg'),
          //fit: BoxFit.cover,
          //),
          SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 100, vertical: 100),
              child: Column(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.asset(
                                  'assets/images/logo22.jpg',
                                  width: 200,
                                ),
                              ),
                              SizedBox(height: 30),
                              Text(
                                'Who are you...?',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                              SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle button press for "Teacher" option
                                  // For example, navigate to the teacher's login page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AdminLogin(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                child: Text('I am an Admin'),
                              ),
                              SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle button press for "Teacher" option
                                  // For example, navigate to the teacher's login page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          TeacherLoginScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                child: Text('I am a Teacher'),
                              ),
                              SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle button press for "Student" option
                                  // For example, navigate to the student's login page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          StudentLoginScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEFFFF),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 18,
                                      color:
                                          Color.fromARGB(255, 254, 254, 254)),
                                ),
                                child: Text('I am a Student'),
                              ),
                              SizedBox(height: 40),
                              ElevatedButton(
                                onPressed: () {
                                  // Handle button press for "Parent" option
                                  // For example, navigate to the parent's login page
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ParentLoginScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xFFFEFEFE),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  textStyle: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                child: Text('I am a Parent'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
