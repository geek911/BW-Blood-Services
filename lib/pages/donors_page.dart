import 'package:bw_blood_final/models/application_user.dart';
import 'package:bw_blood_final/models/centre.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/utils/contact_services.dart';
import 'package:bw_blood_final/utils/validator.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:flutter/material.dart';

class DonorsPage extends StatefulWidget {
  @override
  _DonorsPageState createState() => _DonorsPageState();
}

class _DonorsPageState extends State<DonorsPage> {
  List<ApplicationUser> _allUsers;
  final _editSearchController = TextEditingController();

  @override
  void initState() {
    UserService().getAllUsers().then((value) {
      setState(() {
        _allUsers = value;
      });
    });
    super.initState();
  }

  Widget loadData(List<ApplicationUser> users) {
    List<ApplicationUser> filtered = [];
    if (users != null) {
      filtered = users.where((user) {
        return user.name.contains(_editSearchController.text) ||
            user.email.contains(_editSearchController.text) ||
            user.bloodGroup.contains(_editSearchController.text) ||
            user.bloodGroup.contains(_editSearchController.text);
      }).toList();
    }

    if (users == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if(filtered.isEmpty){
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.search_off, size: 180, color: Colors.red,),
            Text('No result found', style: TextStyle(fontSize: 30, color: Colors.red),)
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filtered.length,
      itemBuilder: (context, index) {
        var u = filtered[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  size: 50,
                  color: Theme.of(context).primaryColor,
                ),
                title: Text(
                  u.name,
                  style:
                      TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        ContactServices().sendEmail(u.email);
                      },
                      child: Text(
                        u.email,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ContactServices().call(u.phone);
                      },
                      child: Text(
                        u.phone,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        u.district,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
                trailing: Text(
                  u.bloodGroup,
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ALL DONORS'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                TextFormField(
                  controller: _editSearchController,
                  validator: validate,
                  decoration: InputDecoration(
                    labelText: 'Search',
                    border: OutlineInputBorder(),
                    suffixIcon: Icon(
                      Icons.search,
                    ),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {});
                      },
                      child: Text('Search')),
                )
              ],
            ),
          ),
          Expanded(child: loadData(this._allUsers)),
        ],
      ),
      drawer: mainDrawer(context),
    );
  }
}
