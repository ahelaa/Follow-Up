import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:followup/screens/student_list_screen.dart';

class customcard extends StatelessWidget {
  const customcard({super.key, this.chatmodel});
  final chatmodel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => TeacherListScreen()));
      },
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: SvgPicture.asset(
                'assets/person.svg',
                height: 38,
                width: 38,
              ),
            ),
            title: Text(
              chatmodel.name,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Icon(Icons.done_all),
                SizedBox(
                  width: 3,
                ),
                Text(
                  chatmodel.currentmessage,
                  style: TextStyle(
                    fontSize: 13,
                  ),
                )
              ],
            ),
            trailing: Text(chatmodel.time),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10, left: 80),
            child: Divider(
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }
}
