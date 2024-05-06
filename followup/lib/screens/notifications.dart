import 'package:followup/screens/Assignments.dart';
import 'package:followup/screens/grades.dart';
import 'package:followup/widgets/buttom.dart';
import 'package:flutter/material.dart';

class Notify extends StatelessWidget {
  const Notify({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff235391),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Notifications',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 30,
            ),
            CustomButtom(
              text: 'new assignment',
              color: Color(0xff235391),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AssignmentPage()),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            CustomButtom(
              text: 'Grades is Out',
              color: Color(0xff235391),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => gradesPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
