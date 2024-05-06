import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class gradesPage extends StatelessWidget {
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
        title: Text('Grades',
        style: TextStyle(color: Colors.white))
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 70),
        child: Align(
          alignment: Alignment.topCenter,
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .collection('grades')
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }
              if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              final QuerySnapshot gradesSnapshot = snapshot.data!;
              final List<DocumentSnapshot> grades = gradesSnapshot.docs;

              if (grades.isEmpty) {
                return Text('No grades found for this user.');
              }

              return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.20), 
                  color: Color(0xff235391),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text
                      ('Course Title',
                      style: TextStyle(color: Colors.white),)),

                      DataColumn(label: Text
                      ('Percentage',
                      style: TextStyle(color: Colors.white))),

                      DataColumn(label: Text
                      ('Grade',
                      style: TextStyle(color: Colors.white))),
                    ],
                    rows: grades.map((grade) {
                      final gradeData = grade.data() as Map<String, dynamic>;
                      final courseTitle = gradeData['courseTitle'] ?? 'No title';
                      final percentage = gradeData['percentage'] ?? 'N/A';
                      final gradeValue = gradeData['grade'] ?? 'N/A';

                      return DataRow(cells: [
                        DataCell(Text(courseTitle.toString(),
                        style: TextStyle(color: Colors.white))),

                        DataCell(Text(percentage.toString(),
                        style: TextStyle(color: Colors.white))),

                        DataCell(Text(gradeValue.toString(),
                        style: TextStyle(color: Colors.white))),
                      ]);
                    }).toList(),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

