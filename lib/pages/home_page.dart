

import 'package:bw_blood_final/constants/routes.dart';
import 'package:bw_blood_final/models/tip.dart';
import 'package:bw_blood_final/services/tip_service.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Tip> _allTips;
  TipService service = TipService();
  @override
  void initState() {
    service.getTips().then((tips) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tip.title,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      IconButton(icon: Icon(Icons.delete, color: Colors.red,), onPressed: () async {
                        await service.deleteTip(tip.id);
                        service.getTips().then((tips) {
                          setState(() {
                            _allTips = tips;
                          });
                        });
                      })
                    ],
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

                          Text('Published On: ' + tip.date.substring(0, 10))
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
        title: Text('BLOG'),
        centerTitle: true,
        actions: [
          UserService.isAdmin ?
          IconButton(icon: Icon(Icons.add), onPressed: ()async {
            await Navigator.pushNamed(context, ADD_DAILY_TIP_PAGE);
          }) : Text('')
        ],
      ),
      body: loadTips(this._allTips),
      drawer: mainDrawer(context),
    );
  }
}












