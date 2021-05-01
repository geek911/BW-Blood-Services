import 'package:cloud_firestore/cloud_firestore.dart';

class Tip {
  String id;
  String title;
  String body;
  String date;

  Tip();

  Tip.fromDoc(QueryDocumentSnapshot doc) {
    id = doc.id;
    title = doc['title'];
    body = doc['body'];
    date = doc['date'];
  }

  Map<String, String> toMap() {
    return {'title': title, 'body': body, 'date': DateTime.now().toString()};
  }
}
