import 'package:cloud_firestore_platform_interface/src/timestamp.dart';

class Message {
  late String content, sender;
  late Map<String, bool> participants;
  late DateTime createdAt;
  Message({
    required this.content,
    required this.sender,
    required List<String> participantsList,
    required Timestamp createdAt,
  }) {
    this.createdAt = DateTime.now();
    participants = Map<String, bool>();
    for (final p in participantsList) {
      participants.putIfAbsent(p.replaceAll('.', '-dot-'), () => true);
    }
  }

  Message.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    sender = json['sender'];
    createdAt = DateTime.fromMillisecondsSinceEpoch(json['createdAt']);
    //participants = json['participants'].cast<Map<String, bool>>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['sender'] = this.sender;
    data['participants'] = this.participants;
    data['createdAt'] = createdAt.millisecondsSinceEpoch;
    return data;
  }
}
