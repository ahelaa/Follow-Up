/* sh8aaaaal daa
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:followup/screens/UploadGradesPage.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  int _selectedYear = 1;
  final CollectionReference<Map<String, dynamic>> users = FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
         leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xff235391),
        title: Text('Students',
        style: TextStyle(color: Colors.white)), 

      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List<Widget>.generate(6, (int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: _selectedYear == index + 1 ? Colors.blue : Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedYear = index + 1;
                    });
                  },
                  child: Text('Year ${index + 1}'),
                ),
              );
            }),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: users.where('year', isEqualTo: _selectedYear).orderBy('username').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                if (!snapshot.hasData) {
                  return CircularProgressIndicator();
                }
                if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                  return Text('No users found');
                }
                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot<Map<String, dynamic>> document) {
                    Map<String, dynamic> data = document.data()!;
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: ((context) => GradeUploadPage(userId: document.id)),
                          )
                          );
                        
                      },
                      child: ListTile(
                        title: Text(data['username']),
                      ),
                    );
                    
                   // return ListTile(
                     // title: Text(data['username']),
                    //);
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}*/
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:followup/screens/UploadGradesPage.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  int? _selectedYear; // Use nullable int to indicate no selection initially
  final CollectionReference<Map<String, dynamic>> users =
      FirebaseFirestore.instance.collection('users');

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
          'Students',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Color(0xff235391),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: DropdownButton<int>(
              dropdownColor: Color(0xff235391),
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.white,
              ),
              underline: SizedBox(),
              onChanged: (int? newValue) {
                setState(() {
                  _selectedYear = newValue;
                });
              },
              items: [
                DropdownMenuItem<int>(
                  value: null,
                  child: Text(
                    _selectedYear == null ? 'Select Year' : 'Year ${_selectedYear!}',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                ...List.generate(6, (index) {
                  return DropdownMenuItem<int>(
                    value: index + 1,
                    child: Text(
                      'Year ${index + 1}',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                }),
              ],
            ),
          ),
          if (_selectedYear != null)
            Expanded(
              child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: users
                    .where('year', isEqualTo: _selectedYear)
                    .orderBy('username')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Text('No users found');
                  }
                  return ListView(
                    children: snapshot.data!.docs
                        .map((DocumentSnapshot<Map<String, dynamic>> document) {
                      Map<String, dynamic> data = document.data()!;
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: ((context) => GradeUploadPage(
                                  userId: document.id)),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Color(0xff235391),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          padding: EdgeInsets.all(8),
                          margin: EdgeInsets.all(25.0),
                          child: ListTile(
                            title: Text(
                              data['username'],
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

