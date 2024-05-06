import 'package:followup/screens/forgetpass.dart';
import 'package:followup/screens/homepage.dart';
import 'package:followup/widgets/buttom.dart';
import 'package:followup/widgets/CustomTextFiled.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  static String id = 'loginpage';

  String? email;

  String? password;

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 60, 130),
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
              ' FOLLOW UP ',
              style: TextStyle(color: Colors.white, fontSize: 35),
            ),
            Spacer(
              flex: 2,
            ),
            //Icon(Icons.account_circle),
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
            //Icon(Icons.lock),
            CustomTextFiled(
              onChanged: (data) {
                password = data;
              },
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            Spacer(
              flex: 1,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (Context) {
                  return forgetpass();
                }));
              },
              child: Text(
                'Forget Password',
                style: TextStyle(color: Colors.black, fontSize: 20),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            CustomButtom(
                text: 'LET ME IN!',
                color: Color(0xff235391),
                onTap: () async {
                  try {
                    // Sign in with email and password
                    UserCredential userCredential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: email!, password: password!);
                    // Check if user is authenticated and has a UID
                    if (userCredential.user != null) {
                      // Navigate to the homepage
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => homepage()),
                      );
                    } else {}
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Invalid Credentials'),
                          content:
                              Text('Please enter valid email and password'),
                          actions: [
                            TextButton(
                              child: Text('OK'),
                              //Close the dialog
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                }),
            Spacer(
              flex: 4,
            ),
          ],
        ),
      ),
    );
  }
}
