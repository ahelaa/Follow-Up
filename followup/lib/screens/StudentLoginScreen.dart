import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:followup/main.dart';
import 'package:followup/widgets/CustomTextFiled.dart';
import 'package:followup/widgets/buttom.dart';

class StudentLoginScreen extends StatefulWidget {
  StudentLoginScreen({Key? key}) : super(key: key);

  static String id = 'loginpage';

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  String? email;

  String? password;

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff235391),
      appBar: AppBar(
        toolbarHeight: 27,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff235391),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.asset(
                'assets/images/logo22.jpg',
                width: 200,
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Text(
              ' WELCOME TO ',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            Text(
              ' F O L L O W - U P ',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Spacer(
              flex: 2,
            ),
            CustomTextFiled(
              onChanged: (data) {
                email = data;
              },
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
            Spacer(
              flex: 1,
            ),
            CustomTextFiled(
              onChanged: (data) {
                password = data;
              },
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
              obscureText: !isPasswordVisible,
            ),
            Spacer(
              flex: 1,
            ),
            Spacer(
              flex: 1,
            ),
            CustomButtom(
              text: 'LET ME IN!',
              color: Color.fromARGB(255, 75, 118, 175),
              onTap: () async {
                try {
                  UserCredential userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: email!,
                    password: password!,
                  );

                  if (userCredential.user != null) {
                    // Check if the user is a teacher
                    DocumentSnapshot teacherSnapshot = await FirebaseFirestore
                        .instance
                        .collection('users')
                        .doc(userCredential.user!.uid)
                        .get();

                    if (teacherSnapshot.exists) {
                      // User is a teacher, navigate to the teacher's homepage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => navigationbarforstudent()),
                      );
                    } else {
                      // User is not a teacher, handle accordingly
                      // For example, show an error dialog
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Invalid User'),
                            content:
                                Text('You are not authorized as a student.'),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  } else {
                    // Handle the case where the user is not authenticated
                  }
                } catch (e) {
                  // Handle login errors
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Invalid Credentials'),
                        content: Text(
                            'Please enter valid email and password \n + $e'),
                        actions: [
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                }
              },
            ),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
