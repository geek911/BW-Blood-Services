import 'package:bw_blood_final/models/application_user.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class DonorsPage extends StatefulWidget {
  @override
  _DonorsPageState createState() => _DonorsPageState();
}

class _DonorsPageState extends State<DonorsPage> {

  List<ApplicationUser> _allUsers;


  @override
  void initState() {
    UserService().getAllUsers().then((value){
      setState(() {
        _allUsers = value;
      });
    });
    super.initState();
  }

  Widget loadData(List<ApplicationUser> users){

    if(users == null){
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        var u = users[index];
        return Padding(

          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: Icon(Icons.person, size: 50, color: Theme.of(context).primaryColor,),
            title: Text(u.name, style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(u.email, textAlign: TextAlign.start,),
                Text(u.phone, textAlign: TextAlign.start,),
                Text(u.district, textAlign: TextAlign.start,),
              ],
            ),
            trailing: Text(u.bloodGroup, style: TextStyle(fontSize: 30, color: Colors.red, fontWeight: FontWeight.bold),),
          ),
        );
      },);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL DONORS'),
        centerTitle: true,
      ),
      body: loadData(this._allUsers),
      drawer: mainDrawer(context),
    );
  }
}
