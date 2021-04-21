import 'package:bw_blood_final/models/application_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final User _currentUser = FirebaseAuth.instance.currentUser;

  Future<ApplicationUser> get currentApplicationUser async {
    var result = await users.where("id", isEqualTo: _currentUser.uid).get();

    ApplicationUser user = ApplicationUser.fromDoc(result.docs.first);
    return user;
  }

  Future<bool> login(String email, String password) async {
    try {
      var result = await this
          .auth
          .signInWithEmailAndPassword(email: email, password: password);
      debugPrint("user id : " + result.user.uid);
      if (result.user == null) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> register(ApplicationUser user) async {
    debugPrint('Registering User: ' + user.email);

    var result = await this.auth.createUserWithEmailAndPassword(
        email: user.email, password: user.password);
    if (result.user == null) {
      return false;
    }
    await users.add({
      "id": result.user.uid,
      "name": user.name,
      "email": user.email,
      "phone": user.phone,
      "age": user.age,
      "village": user.village,
      "bloodGroup": user.bloodGroup,
      "district": user.district,
      "is_admin": user.isAdmin,
    });
    return true;
  }
}
