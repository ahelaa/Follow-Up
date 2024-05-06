import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class Grade {
  final String courseTitle;
  final double percentage;
  final String grade;

  Grade({
    required this.courseTitle,
    required this.percentage,
    required this.grade,
  });

  static Grade fromMap(Map<String, dynamic> data) {
    return Grade(
      courseTitle: data['courseTitle'] ?? '',
      percentage: data['percentage'] ?? 0.0,
      grade: data['grade'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'courseTitle': courseTitle,
      'percentage': percentage,
      'grade': grade,
    };
  }
}

class GradeUploadPage extends StatefulWidget {
  final String userId;

  GradeUploadPage({required this.userId});

  @override
  _GradeUploadPageState createState() => _GradeUploadPageState();
}

class _GradeUploadPageState extends State<GradeUploadPage> {
  final TextEditingController percentageController = TextEditingController();
  String? selectedSubject;
  String? calculatedGrade;

  List<String> subjects = [
    'Math',
    'Science',
    'English',
    'Social study',
    'Arabic',
    'Religion',
    'Computer'
  ];

  void uploadGrade() async {
    if (selectedSubject != null && calculatedGrade != null) {
      final Grade grade = Grade(
        courseTitle: selectedSubject!,
        percentage: double.tryParse(percentageController.text) ?? 0,
        grade: calculatedGrade!,
      );

      try {
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          final CollectionReference<Map<String, dynamic>> userDocRef =
              FirebaseFirestore.instance
                  .collection('users')
                  .doc(widget.userId)
                  .collection('grades');
          // Check if a grade for the selected subject already exists
          final existingGradeSnapshot = await userDocRef
              .where('courseTitle', isEqualTo: selectedSubject)
              .limit(1)
              .get();

          // If an existing grade is found, delete it
          if (existingGradeSnapshot.docs.isNotEmpty) {
            final existingGradeDocId = existingGradeSnapshot.docs.first.id;
            await userDocRef.doc(existingGradeDocId).delete();
          }

          // Add the grade to the Firebase Firestore database
          await userDocRef.add(grade.toMap());

          // Clear the text fields after uploading the grade
          percentageController.clear();

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Grade uploaded successfully!'),
          ));
        }
      } catch (e) {
        // Handle upload failure
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Failed to upload grade: $e'),
        ));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select a subject and enter a percentage.'),
      ));
    }
  }

  String calculateGrade(double percentage) {
    if (percentage >= 95) {
      return 'A+';
    } else if (percentage >= 90) {
      return 'A';
    } else if (percentage >= 85) {
      return 'A-';
    } else if (percentage >= 80) {
      return 'B+';
    } else if (percentage >= 75) {
      return 'B';
    } else if (percentage >= 72) {
      return 'B-';
    } else if (percentage >= 70) {
      return 'C+';
    } else if (percentage >= 65) {
      return 'C';
    } else if (percentage >= 63) {
      return 'C-';
    } else if (percentage >= 62) {
      return 'D+';
    } else if (percentage >= 60) {
      return 'D';
    } else {
      return 'F';
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
        title: Text('Upload Grades', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Color(0xff235391),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    style: TextStyle(color: Colors.white),
                    dropdownColor: Color(0xff235391),
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
                      hintText: 'Select subject',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  TextField(
                    style: TextStyle(color: Colors.white),
                    controller: percentageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter percentage',
                      hintStyle:
                          TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      TextInputFormatter.withFunction(
                          (TextEditingValue oldValue,
                              TextEditingValue newValue) {
                        if (newValue.text.isNotEmpty &&
                            int.parse(newValue.text) > 100) {
                          return oldValue;
                        }
                        return newValue;
                      }),
                    ],
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
          SizedBox(height: 16.0),
          Container(
            width: MediaQuery.of(context).size.width * 0.4,
            child: ElevatedButton(
              onPressed: () {
                calculatedGrade = calculateGrade(
                    double.tryParse(percentageController.text) ?? 0);
                uploadGrade();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff235391),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              child: Text(
                'Upload',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
