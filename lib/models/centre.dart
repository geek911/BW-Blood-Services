import 'package:cloud_firestore/cloud_firestore.dart';

class Centre {
  String id;
  String name;
  String location;
  String phoneNumber = "Not Provided";
  String other = '';

  Centre();

  Centre.fromDoc(QueryDocumentSnapshot doc) {
    this.id = doc.id;
    this.name = doc['name'];
    this.location = doc['location'];
    this.phoneNumber = doc['phone_number'];
    this.other = doc['other'];
  }

  Map<String, String> toMap() {
    return {
      'name': name,
      'location': location,
      'phone_number': phoneNumber,
      'other': other
    };
  }
}
