

import 'package:bw_blood_final/constants/routes.dart';
import 'package:bw_blood_final/models/tip.dart';
import 'package:bw_blood_final/services/tip_service.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Tip> _allTips;

  @override
  void initState() {
    TipService().getTips().then((tips) {
      setState(() {
        _allTips = tips;
      });
    });
    super.initState();
  }

  Widget loadTips(List<Tip> tips) {
    if (tips == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return ListView.builder(
        itemCount: tips.length,
        itemBuilder: (context, index) {
          var tip = tips[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tip.title,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  Divider(
                    height: 20,
                  ),
                  SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tip.body,
                            style: TextStyle(fontSize: 17),
                          ),

                          Divider(),

                          Text('Published: ' + tip.date)
                        ],
                      )),
                ],
              ),
            ),
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('DAILY TIPS'),
        centerTitle: true,
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: ()async {
            await Navigator.pushNamed(context, ADD_DAILY_TIP_PAGE);
          })
        ],
      ),
      body: loadTips(this._allTips),
      drawer: mainDrawer(context),
    );
  }
}












