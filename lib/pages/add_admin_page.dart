import 'package:bw_blood_final/models/centre.dart';
import 'package:bw_blood_final/services/centre_services.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/utils/validator.dart';
import 'package:bw_blood_final/widgets/main_drawer.dart';
import 'package:bw_blood_final/widgets/progressBar.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class AddAdminPage extends StatefulWidget {
  @override
  _AddAdminPageState createState() => _AddAdminPageState();
}

class _AddAdminPageState extends State<AddAdminPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  CenterServices _services = CenterServices();
  UserService _userService = UserService();
  Map<String, String> _centres = {}; // name - key, id - value
  String selectedCentre = "";

  @override
  void initState() {
    _services.getAllCenters().then((centres) {
      setState(() {
        centres.forEach((element) {
          _centres.putIfAbsent(element.name, () => element.id);
          setState(() {
            selectedCentre = _centres.keys.first;
          });
        });
      });
    });
    super.initState();
  }

  Future<void> _addAdmin() async {
    await _userService.updateToAdmin(
        _emailController.text, _centres[selectedCentre]);
    _emailController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Admin'),
          centerTitle: true,
        ),
        drawer: mainDrawer(context),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                      'Please ensure the person is already registered as a regular user'),
                  SizedBox(
                    height: 5,
                  ),
                  TextFormField(
                    controller: _emailController,
                    validator: validateEmail,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(
                        Icons.email,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedCentre,
                      items: _centres.keys.map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: new Text(value, style: TextStyle(fontSize: 18),),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCentre = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        var pr = progressIndicator(context, 'please wait');
                        try {
                          if (_formKey.currentState.validate()) {
                            pr.show();
                            await _addAdmin();
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text('Done')));

                            pr.hide();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Check the entered email')));
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'User does not exist / is not in the system at all')));
                          pr.hide();
                        }
                      },
                      child: Text('Add'))
                ],
              ),
            ),
          ),
        ));
  }
}
