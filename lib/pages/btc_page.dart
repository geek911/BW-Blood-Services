import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class BTCPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOOD TRANSFUSION CENTRE'),
        centerTitle: true,
      ),
      drawer: mainDrawer(context),
    );
  }
}
