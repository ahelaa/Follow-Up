import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  List<Appointment>? data;
  String? year;
  @override
  void initState() {
    super.initState();
    getAppointments().then((value) => setState(() {
          data = value;
        }));
  }

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
        title: Text(
          'Schedule for Year ${year ?? ''} ',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: data == null
          ? CircularProgressIndicator()
          : SfCalendar(
              view: CalendarView.week,
              firstDayOfWeek: 6,
              dataSource: MeetingDataSource(data!),
            ),
    );
  }

  Future<List<Appointment>> getAppointments() async {
    final user = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    year = user.data()!['year'].toString();
    final snapshots = await FirebaseFirestore.instance
        .collection('schedules')
        .doc(user.data()!['year'].toString())
        .collection('appointments')
        .limit(1000)
        .get();
    List<Appointment> meetings = [];
    for (final document in snapshots.docs) {
      Timestamp s = document['StartTime'];
      Timestamp e = document['EndTime'];
      meetings.add(Appointment(
        startTime: s.toDate(),
        endTime: e.toDate(),
        subject: document["Subject"],
        color: Color(0xff235391),
      ));
    }

    return meetings;
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
