import 'package:bw_blood_final/models/AppointmentUser.dart';
import 'package:bw_blood_final/models/appointment.dart';
import 'package:bw_blood_final/pages/appointment_page.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bw_blood_final/utils/datetime_extensions.dart';

class AppointmentService {
  CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');
  User user = FirebaseAuth.instance.currentUser;
  UserService _userService = UserService();

  Future<void> deleteAppointment(String id) async {
    await appointments.doc(id).delete();
  }

  Future<void> addAppointment(Appointment appointment) async {
    var result = await getMyAppointments();
    var days = result.where((element) {
      return element.date.isSameDate(appointment.date);
    });
    debugPrint('Days : ' + days.length.toString());
    if (days.length == 0) {
      appointment.userId = user.uid;
      await appointments.add(appointment.toMap());
    }
  }

  Future<List<Appointment>> getMyAppointments() async {
    debugPrint('Getting appointments');
    List<Appointment> myApp = [];
    QuerySnapshot snapshot = await this.appointments.get();
    for (var doc in snapshot.docs) {
      if (doc['user_id'] == user.uid) {
        Appointment appointment = Appointment.fromDoc(doc);
        myApp.add(appointment);
      }
    }

    return myApp;
  }

  Future<List<Appointment>> getCentreAppointmentsForUser() async {
    var user = await _userService.currentApplicationUser;
    var result = await this
        .appointments
        .where('centre_id', isEqualTo: user.isAdminFor)
        .get();
    List<Appointment> appointments = [];
    for (var doc in result.docs) {
      Appointment appointment = Appointment.fromDoc(doc);
      debugPrint('appointment: ' + appointment.id);
      appointments.add(appointment);
    }

    return appointments;
  }
  Future<List<AppointmentUser>> getAppointmentJoinedWithUser() async {

    List<Appointment> appointments = await getCentreAppointmentsForUser();
    List<AppointmentUser> ua = [];

    for(var appointment in appointments){

      var user = await _userService.getUserById(appointment.userId);

      ua.add(AppointmentUser(appointment, user));

    }

    return ua;
  }

  Future<void> approveAppointment(String id) async{
    await appointments.doc(id).update({'status': 'approved'});

  }
  Future<void> rejectAppointment(String id) async{
    await appointments.doc(id).update({'status': 'rejected'});

  }
}
