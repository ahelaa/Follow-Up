
import 'package:followup/screens/UploadPage.dart';
import 'package:flutter/material.dart';
//import 'package:followup/widgets/custombutton1';
import 'package:followup/widgets/custombutton1.dart';

class TeacherUpload extends StatelessWidget {
  const TeacherUpload({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff235391),
          leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Text(
              ' upload  ',
              style: TextStyle(color: Color(0xff235391), fontSize: 40),
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton1(
              text: 'Assignments',
              color: Color(0xff235391),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton1(
              text: 'Reports',
              color: Color(0xff235391),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPage(),
                  ),
                );
              },
            ),
            SizedBox(
              height: 30,
            ),
            CustomButton1(
              text: 'Grades',
              color: Color(0xff235391),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UploadPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
