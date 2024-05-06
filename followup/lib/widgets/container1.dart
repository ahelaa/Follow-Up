import 'package:flutter/material.dart';

/*
class container1 extends StatelessWidget {
  container1({this.color, this.subject, this.assignmentText});

  final Color? color;
  final String? subject;
  final String? assignmentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff235391),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.notes_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Buttom2(
            text: 'Open',
            color: Color(0xff235391),
            assignmentText: assignmentText ?? '',
          ),
        ],
      ),
    );
  }
}*/

class Buttom2 extends StatelessWidget {
  final String text;
  final Color color;
  final String assignmentText; // Add assignmentText parameter

  Buttom2(
      {required this.text, required this.color, required this.assignmentText});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Your assignment is: '),
              content:
                  Text(assignmentText), // Display assignment text in dialog
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Close'),
                ),
              ],
            );
          },
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              10), // Set border radius to 0 for rectangular shape
        ),
      ),
      child: Text(
        text,
        style: TextStyle(color: Color(0xff235391)), // Set text color here
      ),
    );
  }
}

class container1 extends StatelessWidget {
  container1({this.color, this.subject, this.assignmentText});

  final Color? color;
  final String? subject;
  final String? assignmentText;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 12),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
      ),
      height: 150, // Specify a fixed height
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xff235391),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  Icons.notes_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Buttom2(
            text: 'Open',
            color: Colors.white,
            assignmentText: assignmentText ?? '',
          ),
        ],
      ),
    );
  }
}
