
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class AppointmentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Appointment'),
        centerTitle: true,
      ),
      drawer: mainDrawer(context),
    );
  }
}
