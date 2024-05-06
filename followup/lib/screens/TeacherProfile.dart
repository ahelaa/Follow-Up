import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key? key}) : super(key: key);

  @override
  State<TeacherProfile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<TeacherProfile> {
  late String _username = '';
  late String _phoneNumber = '';

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchLoggedInUserData();
  }

  void fetchLoggedInUserData() async {
    try {
      String userId = FirebaseAuth.instance.currentUser!.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .doc(userId)
          .get();

      if (userSnapshot.exists) {
        Map<String, dynamic> userData =
            userSnapshot.data() as Map<String, dynamic>;
        setState(() {
          _username = userData['username'] ?? '';
          _phoneNumber = userData['phoneNumber'] ?? '';
          // Check if 'year' is not null and is of type int

          _isLoading = false;
        });
      } else {
        print('User data not found');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (error) {
      print('Error fetching user data: $error');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff235391),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff235391),
        title: Text(
          ' Profile',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Color(0xff235391),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          maxRadius: 50,
                          minRadius: 50,
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: Colors.grey,
                          ),
                          //child: SvgPicture.asset(
                          //'assets/person.svg',
                          //height: 38,
                          //width: 38,
                          //),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '$_username',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 28),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 204, 204, 204),
                        borderRadius: BorderRadius.circular(20)),
                    width: 400,
                    height: 130,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(children: [
                            Text(
                              'personal info:',
                              style: TextStyle(
                                color: Color(0xff235391),
                                fontSize: 20,
                              ),
                            ),
                            Row(
                              children: [
                                Icon(Icons.phone),
                                Text(
                                  '$_phoneNumber',
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0XFF235391)),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.email),
                                Text(
                                  '$_username@gmail.com',
                                  style: TextStyle(
                                      fontSize: 20, color: Color(0XFF235391)),
                                )
                              ],
                            ),
                          ])
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
