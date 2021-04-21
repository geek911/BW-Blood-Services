import 'package:cloud_firestore/cloud_firestore.dart';

class Appointment {
  String id;
  DateTime date;
  String centreId;
  String userId;
  String status = 'pending';

  Appointment();

  Appointment.fromDoc(QueryDocumentSnapshot doc) {
    id = doc.id;
    date = DateTime.parse(doc['date']);
    centreId = doc['centre_id'];
    userId = doc['user_id'];
    status = doc['status'];
  }

  Map<String, String> toMap() {
    return {
      'date': this.date.toString(),
      'centre_id': centreId,
      'user_id': userId,
      'status': status
    };
  }
}
