
import 'package:bw_blood_final/models/tip.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TipService {
  CollectionReference tipsCollection =
  FirebaseFirestore.instance.collection("tips");

  Future<void> addTip(Tip tip) async {
    await tipsCollection.add(tip.toMap());
  }

  Future<List<Tip>> getTips() async {
    List<Tip> tips = [];
    QuerySnapshot snapshot = await this.tipsCollection.get();

    for (var doc in snapshot.docs) {
      Tip tip = Tip.fromDoc(doc);
      debugPrint(tip.title);
      tips.add(tip);
    }
    return tips;
  }
}