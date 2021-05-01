import 'package:bw_blood_final/models/application_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserService {
  static bool isAdmin = false;

  final FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference users =
      FirebaseFirestore.instance.collection("users");
  final User _currentUser = FirebaseAuth.instance.currentUser;
  final administrators = FirebaseFirestore.instance.collection("administrator");
  Future<ApplicationUser> get currentApplicationUser async {
    var result = await users.where("id", isEqualTo: _currentUser.uid).get();

    ApplicationUser user = ApplicationUser.fromDoc(result.docs.first);
    return user;
  }

  Future<ApplicationUser> getUserById(String id) async {
    var result = await users.where("id", isEqualTo: id).get();
    var user = ApplicationUser.fromDoc(result.docs.first);
    return user;
  }

  Future<bool> loginAsAdmin(String email, String password) async {
    var result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    if (result != null) {
      var user = await this.currentApplicationUser;
      if (user.isAdminFor.isNotEmpty) {
        isAdmin = true;
        return true;
      }
    }
    await logout();
    return false;
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
    user.id = result.user.uid;
    await users.add(user.toMap());
    return true;
  }

  Future<List<ApplicationUser>> getAllUsers() async {
    List<ApplicationUser> users = [];
    var snapshot = await this.users.get();
    for (var doc in snapshot.docs) {
      if (doc['email'] == auth.currentUser.email) {
        continue;
      }
      var user = ApplicationUser.fromDoc(doc);
      users.add(user);
    }
    return users;
  }

  Future<void> logout() async {
    await auth.signOut();
  }

  Future<void> updateToAdmin(String email, String centreId) async {
    var result = await users.where('email', isEqualTo: email).get();
    await users.doc(result.docs.first.id).update({'is_admin': 'true', 'is_admin_for': centreId});
    ApplicationUser user = ApplicationUser.fromDoc(result.docs.first);
    await administrators.add({
      'user_id': user.id,
      'centre_id': centreId
    });
    // debugPrint(centreId);
  }
}
