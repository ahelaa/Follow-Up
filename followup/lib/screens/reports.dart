import 'package:flutter/material.dart';
import 'package:followup/widgets/attachcont.dart';
import 'package:followup/widgets/attendancecont.dart';
import 'package:followup/widgets/behaviorcont.dart';
import 'package:followup/widgets/classworkcont.dart';

class reportspage extends StatelessWidget {
  const reportspage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff235391),
        title: Text(
          'Reports',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
          ),
          behaviorcont(
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          attendancecont(
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          classworkcont(
            color: Colors.grey,
          ),
          SizedBox(
            height: 20,
          ),
          attachcont(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
