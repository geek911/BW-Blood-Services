import 'package:bw_blood_final/models/centre.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CenterServices {
  CollectionReference centres =
      FirebaseFirestore.instance.collection('centres');

  Future<List<Centre>> getAllCenters() async {
    List<Centre> allCenters = [];

    var snapshots = await this.centres.get();

    for (var doc in snapshots.docs) {
      debugPrint(doc['name']);
      Centre center = Centre.fromDoc(doc);
      allCenters.add(center);
    }

    return allCenters;
  }

  Future<void> addCentre(Centre centre) async {
    await centres.add(centre.toMap());
  }




}
