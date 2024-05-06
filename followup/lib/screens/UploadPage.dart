import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Assignment {
  final String subject;
  final String assignmentText;

  Assignment({
    required this.subject,
    required this.assignmentText,
  });

  static Assignment fromMap(Map<String, dynamic> data) {
    return Assignment(
      subject: data['subject'] ?? '',
      assignmentText: data['assignmentText'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subject': subject,
      'assignmentText': assignmentText,
    };
  }
}

class UploadPage extends StatefulWidget {
  @override
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  String? selectedYear;
  String? selectedSubject;
  TextEditingController assignmentController = TextEditingController();

  List<String> years = ['1', '2', '3', '4', '5', '6'];
  List<String> subjects = [
    'Math',
    'Science',
    'English',
    'Social study',
    'Arabic',
    'Religion',
    'Computer'
  ];

  void submitAssignment() async {
    if (selectedYear != null &&
        selectedSubject != null &&
        assignmentController.text.isNotEmpty) {
      try {
        final CollectionReference<Map<String, dynamic>> usersCollectionRef =
            FirebaseFirestore.instance.collection('users');

        // Query users with the selected year
        final QuerySnapshot<Map<String, dynamic>> usersSnapshot =
            await usersCollectionRef
                .where('year', isEqualTo: int.parse(selectedYear!))
                .get();

        if (usersSnapshot.docs.isNotEmpty) {
          // Save the assignment for users who have the selected year
          usersSnapshot.docs.forEach((userDoc) async {
            final String userId = userDoc.id;
            final CollectionReference<Map<String, dynamic>>
                assignmentsCollectionRef =
                usersCollectionRef.doc(userId).collection('assignments');

            // Add the assignment to the Firestore database
            await assignmentsCollectionRef.add({
              'subject': selectedSubject,
              'assignmentText': assignmentController.text,
            });
          });

          // Clear the assignment text field after submission
          assignmentController.clear();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Assignment submitted successfully!'),
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('No users found with the selected year.'),
          ));
        }
      } catch (e) {
        // Handle Firestore errors
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to submit assignment: $e'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content:
            Text('Please select a year, subject, and write the assignment.'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Color(0xff235391),
        title: Text(
          'Upload Assignment',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              'assets/images/assignments.jpg',
              //fit: BoxFit.cover,
              height: 200,
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedYear,
              items: years.map((String year) {
                return DropdownMenuItem<String>(
                  value: year,
                  child: Text(year),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedYear = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Choose a Year',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedSubject,
              items: subjects.map((String subject) {
                return DropdownMenuItem<String>(
                  value: subject,
                  child: Text(subject),
                );
              }).toList(),
              onChanged: (String? value) {
                setState(() {
                  selectedSubject = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Choose a Subject',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              controller: assignmentController,
              maxLines: null,
              maxLength: 1000,
              decoration: InputDecoration(
                labelText: 'Write Your Assignment',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: 200,
              child: ElevatedButton(
                onPressed: submitAssignment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff235391),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                ),
                child: Text(
                  'Submit Assignment',
                  style:
                      TextStyle(color: Colors.white), // Set text color to white
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
