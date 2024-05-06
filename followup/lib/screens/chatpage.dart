import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:followup/model/message.dart';
import 'package:followup/widgets/chatbubble.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'student_list_screen.dart';

class ChatPage extends StatelessWidget {
  final CUser recipient; // CUser is a variable to hold the recipient user data

  ChatPage({
    required this.recipient,
  });

  static String id = 'chatpage';
  final _controller = ScrollController();
  final TextEditingController controller = TextEditingController();
  final collectionRef = FirebaseFirestore.instance
      .collection('messages'); // Reference to Firebase collection 'messages'

  @override
  Widget build(BuildContext context) {
    final currentUser =
        FirebaseAuth.instance.currentUser!; // Get the current user
    final myUid = currentUser.uid!; // Get the current user UID

    final myEmailPath = FieldPath([
      "participants",
      recipient.uid.replaceAll('.', '-dot-')
    ]); // Define the path of the current user in firestore
    final recipientPath = FieldPath([
      "participants",
      myUid.replaceAll('.', '-dot-')
    ]); // Define the path of the recipient user in firestore

    final messages = FirebaseFirestore.instance
        .collection('messages')
        .where(myEmailPath, isEqualTo: true)
        .where(recipientPath, isEqualTo: true);

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
          recipient.displayName,
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: messages.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Message> messagesList = snapshot.data!.docs
                      .map((snapshot) => Message.fromJson(
                          snapshot.data() as Map<String, dynamic>))
                      .toList();

                  messagesList.sort((m1, m2) => m1.createdAt
                      .compareTo(m2.createdAt)); //Sort messages by timestamp

                  //return Text(messagesList.length.toString());

                  return ListView.builder(
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      final message = messagesList[index];
                      if (message.sender == myUid) {
                        return chatbubble(
                          message: message,
                          isMyMessage: true,
                        );
                      } else {
                        return chatbubbleForFriend(
                          message: message,
                        );
                      }
                    },
                  );
                  //print(snapshot.data!.docs[0]['message']);
                } else {
                  return Text('Loading');
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: controller,
              onSubmitted: (data) => _submit(data, myUid),
              decoration: InputDecoration(
                hintText: 'send message',
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: Color(0xff235391)),
                  onPressed: () {
                    _submit(controller.text, myUid);
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: Color(0xff235391),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  _submit(data, myUid) {
    collectionRef.add(Message(
            content: data,
            sender: myUid,
            participantsList: [
              myUid,
              recipient.uid,
            ],
            createdAt: Timestamp.now())
        .toJson());
    controller.clear();
    try {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    } catch (ex) {}
  }
}
