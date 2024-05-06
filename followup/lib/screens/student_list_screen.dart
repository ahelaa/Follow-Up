import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:followup/main.dart';
import 'package:followup/screens/chatpage.dart';

// Define a simple User class to represent user data
class CUser {
  final String uid;
  final String displayName;

  CUser({required this.uid, required this.displayName});
}

class TeacherListScreen extends StatelessWidget {
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
        title: Text(
          'Teachers',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff235391),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('teachers').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          // If snapshot has data
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView(
              padding: EdgeInsets.all(16), // Add padding to the ListView
              children: snapshot.data!.docs.map((document) {
                // Access each document's data
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return GestureDetector(
                  // Wrap ListTile with GestureDetector
                  onTap: () async {
                    // Fetch user data based on username
                    String recipientUsername = data['username'];
                    final recipient =
                        await fetchUserByUsername(recipientUsername);
                    if (recipient != null) {
                      // Navigate to ChatPage with recipient user
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            recipient: recipient,
                          ),
                        ),
                      );
                    } else {
                      // Handle case where user is not found
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('User Not Found'),
                            content: Text('Could not find user data.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 8), // Add vertical margin
                    padding: EdgeInsets.all(12), // Add padding to the container
                    decoration: BoxDecoration(
                      color: Color(0xff235391), // Transparent box
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      title: Row(
                        children: [
                          Text(
                            data['username'],
                            style: TextStyle(color: Colors.white),
                          ),
                          SizedBox(width: 8),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection('messages')
                                .where('receiver', isEqualTo: data['username'])
                                .where('read', isEqualTo: false)
                                .snapshots(),
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> messageSnapshot) {
                              if (messageSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              }
                              if (messageSnapshot.hasError) {
                                return Text('Error: ${messageSnapshot.error}');
                              }
                              int unreadCount =
                                  messageSnapshot.data?.docs.length ?? 0;
                              return unreadCount > 0
                                  ? CircleAvatar(
                                      radius: 10,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        '$unreadCount',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    )
                                  : SizedBox();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Text('No student users found');
          }
        },
      ),
    );
  }

  // Function to fetch user data based on username
  Future<CUser?> fetchUserByUsername(String username) async {
    try {
      // Query Firestore for the user with the specified username
      print(username);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('teachers')
          .where('username', isEqualTo: username)
          .limit(1) // Limit the result to one document
          .get();

      // If the query returned any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Retrieve user data from the document
        String uid = querySnapshot.docs.first.id;
        String displayName = userData[
            'username']; // Assuming username is stored in 'username' field

        // Create a User object
        CUser user = CUser(uid: uid, displayName: displayName);
        // Return the User object
        return user;
      } else {
        // If no documents found, return null
        return null;
      }
    } catch (error) {
      // Handle any errors
      print('Error fetching user: $error');
      return null;
    }
  }
}

// Return the User

class StudentListScreen extends StatelessWidget {
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
        title: Text(
          'Students',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xff235391),
      ),
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }
          // If snapshot has data
          if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
            return ListView(
              padding: EdgeInsets.all(16), // Add padding to the ListView
              children: snapshot.data!.docs.map((document) {
                // Access each document's data
                Map<String, dynamic> data =
                    document.data() as Map<String, dynamic>;
                return GestureDetector(
                  // Wrap ListTile with GestureDetector
                  onTap: () async {
                    // Fetch user data based on username
                    String recipientUsername = data['username'];
                    final recipient =
                        await fetchUserByUsername(recipientUsername);
                    if (recipient != null) {
                      // Navigate to ChatPage with recipient user
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatPage(
                            recipient: recipient,
                          ),
                        ),
                      );
                    } else {
                      // Handle case where user is not found
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('User Not Found'),
                            content: Text('Could not find user data.'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        vertical: 8), // Add vertical margin
                    padding: EdgeInsets.all(12), // Add padding to the container
                    decoration: BoxDecoration(
                      color: Color(0xff235391), // Transparent box
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      title: Text(
                        data['username'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Text('No student users found');
          }
        },
      ),
    );
  }

  // Function to fetch user data based on username
  Future<CUser?> fetchUserByUsername(String username) async {
    try {
      // Query Firestore for the user with the specified username
      print(username);
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: username)
          .limit(1) // Limit the result to one document
          .get();

      // If the query returned any documents
      if (querySnapshot.docs.isNotEmpty) {
        // Get the first document
        var userData = querySnapshot.docs.first.data() as Map<String, dynamic>;

        // Retrieve user data from the document
        String uid = querySnapshot.docs.first.id;
        String displayName = userData[
            'username']; // Assuming username is stored in 'username' field

        // Create a User object
        CUser user = CUser(uid: uid, displayName: displayName);

        // Return the User object
        return user;
      } else {
        // If no documents found, return null
        return null;
      }
    } catch (error) {
      // Handle any errors
      print('Error fetching user: $error');
      return null;
    }
  }
}
