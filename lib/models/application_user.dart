import 'package:cloud_firestore/cloud_firestore.dart';

class ApplicationUser {
  String id;
  String name;
  String email;
  String phone;
  String age;
  String village;
  String bloodGroup;
  String district;
  String password;
  String isAdmin;

  ApplicationUser();

  ApplicationUser.fromDoc(QueryDocumentSnapshot doc) {
    this.id = doc['id'];
    this.name = doc['name'];
    this.email = doc['email'];
    this.phone = doc['phone'];
    this.age = doc['age'];
    this.village = doc['village'];
    this.bloodGroup = doc['bloodGroup'];
    this.district = doc['district'];
    this.isAdmin = doc['is_admin'];
  }
}
