import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:followup/screens/UploadPage.dart';
import 'package:followup/screens/listGrades.dart';
import 'package:followup/screens/notifications.dart';

class TeacherHome extends StatefulWidget {
  int? currentindex;
  //const TeacherHome({super.key});

  @override
  State<TeacherHome> createState() => _TeacherHomeState();
}

class _TeacherHomeState extends State<TeacherHome> {
  late String _username;

  @override
  void initState() {
    super.initState();
    // Fetch the logged-in user's username when the widget initializes
    fetchLoggedInUsername();
  }

  void fetchLoggedInUsername() async {
    // Get the current user's ID
    String userId = FirebaseAuth.instance.currentUser!.uid;
    // Query Firestore to get the user document
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('teachers')
        .doc(userId)
        .get();
    // Extract the username from the user document
    String username = userSnapshot['username'];
    // Update the state with the retrieved username
    setState(() {
      _username = username;
    });
  }

  List imageList = [
    {"id": 1, "image_path": 'assets/images/ads1.jpg'}, //path el image
    {"id": 2, "image_path": 'assets/images/ads2.jpg'}, //path el image
    {"id": 3, "image_path": 'assets/images/ads3.jpg'}, //path el image
    {"id": 4, "image_path": 'assets/images/ads4.jpg'}, //path el image
  ];

  final CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(
                      'Hi, $_username',
                      style: TextStyle(
                        color: Color(0xff235391),
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const Notify(); // page el notification
                    }));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff235391),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(16),
                    child: const Icon(
                      Icons.notifications,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              width: MediaQuery.of(context).size.width * .7,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff235391)),
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: InkWell(
                onTap: () {
                  
                },
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search,
                        color: Color(0xff235391),
                      ),
                      SizedBox(width: 8.0),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Color(0xff235391),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  InkWell(
                    child: CarouselSlider(
                      items: imageList
                          .map(
                            (item) => Image.asset(
                              item['image_path'],
                              fit: BoxFit.fill,
                              width: double.infinity,
                            ),
                          )
                          .toList(),
                      carouselController: carouselController,
                      options: CarouselOptions(
                        scrollPhysics: const BouncingScrollPhysics(),
                        autoPlay: true,
                        aspectRatio: 2,
                        viewportFraction: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * .13,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UsersPage())); //esm el screan
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/grades.jpg"), //soret el schedule
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Text(
                            "Grades",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * .13,
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UploadPage())); //esm el screan
                      },
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 3, left: 3),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: const DecorationImage(
                                image: AssetImage(
                                    "assets/images/assignments.jpg"), // soret el assignment
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          const Text(
                            "Assignments",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w900,
                                color: Colors.white),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
