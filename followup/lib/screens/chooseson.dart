import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:followup/widgets/buttom.dart';

class Chooseson extends StatelessWidget {
  const Chooseson({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return Center(
        child: Text('No user logged in.'),
      );
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('parents')
          .doc(user
              .uid) // Use the current user's ID to fetch the parent document
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          final studentReference =
              snapshot.data!['student'] as DocumentReference?;
          if (studentReference != null) {
            return StreamBuilder<QuerySnapshot>(
              stream: studentReference
                  .collection('grades')
                  .snapshots(), // Stream for the grades subcollection
              builder: (context, gradesSnapshot) {
                if (gradesSnapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (gradesSnapshot.hasError) {
                  return Center(child: Text('Error: ${gradesSnapshot.error}'));
                } else {
                  final studentData = snapshot.data;
                  final studentName = studentData?['username'] as String?;

                  return Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Image(
                          image: AssetImage('assets/images/backgroundd.jpg'),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Column(
                            children: [
                              SizedBox(height: 20),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  'assets/images/logo22.jpg',
                                  width: 150,
                                ),
                              ),
                              SizedBox(height: 20),
                              CustomButtom(
                                text: studentName ?? 'Student',
                                color: Color(0xff235391),
                              ),
                              if (gradesSnapshot.data!.docs.isNotEmpty)
                                Column(
                                  children: gradesSnapshot.data!.docs
                                      .map<Widget>((gradeDoc) {
                                    final grade = gradeDoc['grade'] as String?;
                                    return Text('Grade: $grade');
                                    
                                  }).toList(),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }
              },
            );
          } else {
            return Center(child: Text('No student assigned.'));
          }
        }
      },
    );
  }
}
