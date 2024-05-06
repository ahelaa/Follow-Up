import 'package:firebase_auth/firebase_auth.dart';
import 'package:followup/screens/splash.dart';
import 'package:followup/widgets/buttom.dart';
import 'package:flutter/material.dart';

class settingspage extends StatelessWidget {
  const settingspage({super.key});

  Future<void> signOut() async {
    return await FirebaseAuth.instance.signOut();
  }

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  //@override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Settings',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff235391),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            CustomButtom(
              text: 'Help',
              color: Color(0xff235391),
            ),
            SizedBox(
              height: 30,
            ),
            CustomButtom(
              text: 'About',
              color: Color(0xff235391),
            ),
            SizedBox(
              height: 30,
            ),
            CustomButtom(
              text: 'Logout',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => numberone()),
                );
              },
              color: Color(0xff235391),
            ),
          ],
        ),
      ),
    );
  }
}
