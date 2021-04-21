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
  String isAdminFor = "";

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
    this.isAdminFor = doc['is_admin_for'];
  }

  Map<String, String> toMap(){
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "phone": this.phone,
      "age": this.age,
      "village": this.village,
      "bloodGroup": this.bloodGroup,
      "district": this.district,
      "is_admin": this.isAdmin,
      "is_admin_for": this.isAdminFor
    };
  }
}
