import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:followup/widgets/container1.dart';
class AssignmentPage extends StatelessWidget {
  static String id = 'assignmentpage';

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      // Handle the case where no user is logged in
      return Center(
        child: Text('No user logged in.'),
      );
    }

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
          'Assignments',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(user.uid)
            .collection('assignments')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No assignments found.'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final assignment = snapshot.data!.docs[index];
                final subject = assignment['subject'] as String?;
                final assignmentText = assignment['assignmentText'] as String?;
                return container1(
                  color: Color(0xff235391),
                  subject: subject ?? 'No subject',
                  assignmentText: assignmentText ?? 'No assignment text',
                );
              },
            );
          }
        },
      ),
    );
  }
}
