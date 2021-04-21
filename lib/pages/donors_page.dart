import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class DonorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL DONORS'),
        centerTitle: true,
      ),
      drawer: mainDrawer(context),
    );
  }
}
