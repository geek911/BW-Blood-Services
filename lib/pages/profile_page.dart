import 'package:bw_blood_final/constants/routes.dart';
import 'package:bw_blood_final/models/application_user.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  ApplicationUser _user;
  UserService _service = UserService();

  @override
  void initState() {
    _service.currentApplicationUser.then((value) {
      setState(() {
        _user = value;
      });
    });
    super.initState();
  }

  Widget initBody() {
    if (_user == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Card(
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _user.name,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Divider(
                height: 10,
              ),
              Text(
                'BLOOD GROUP : ' + _user.bloodGroup,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              Divider(
                height: 10,
              ),
              Text(
                _user.email,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _user.district,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                _user.phone,
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PROFILE'),
        centerTitle: true,
        actions: [IconButton(icon: Icon(Icons.edit), onPressed: () async {

          await Navigator.pushNamed(context, EDIT_PROFILE_PAGE);
        })],
      ),
      body: initBody(),
      drawer: mainDrawer(context),
    );
  }
}
