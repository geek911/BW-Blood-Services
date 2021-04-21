import 'package:bw_blood_final/constants/routes.dart';
import 'package:bw_blood_final/models/centre.dart';
import 'package:bw_blood_final/services/centre_services.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class BTCPage extends StatefulWidget {
  @override
  _BTCPageState createState() => _BTCPageState();
}

class _BTCPageState extends State<BTCPage> {

  List<Centre> _allCenters = [];
  @override
  void initState() {
    CenterServices().getAllCenters().then((value){
      setState(() {
        _allCenters = value;
      });
    });
    super.initState();
  }

  Widget loadList(List<Centre> centres){
    if(centres == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }else {
      return ListView.builder(
        itemCount: centres.length,
        itemBuilder: (context, index) {
          var c = centres[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(c.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  SizedBox(height: 10,),
                  Text(c.phoneNumber, style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  Text(c.location, style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
          );
        },);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BLOOD TRANSFUSION CENTRE'),
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: () async{
            await Navigator.pushNamed(context, ADD_BTC_PAGE);
          })
        ],
        centerTitle: true,
      ),
      body:  loadList(_allCenters),
      drawer: mainDrawer(context),
    );
  }
}
