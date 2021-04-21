import 'package:bw_blood_final/constants/values.dart';
import 'package:bw_blood_final/models/application_user.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/utils/validator.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordConfirmController =
      TextEditingController();
  final TextEditingController ageConfirmController = TextEditingController();
  final TextEditingController villageConfirmController =
      TextEditingController();
  final TextEditingController bloodGroupConfirmController =
      TextEditingController();
  final TextEditingController districtConfirmController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isAdmin = false;

  Future<bool> _register() async {
    ApplicationUser user = ApplicationUser()
      ..name = nameController.value.text
      ..email = emailController.value.text
      ..phone = phoneController.value.text
      ..password = passwordController.value.text
      ..age = ageConfirmController.value.text
      ..village = villageConfirmController.value.text
      ..bloodGroup = bloodGroupConfirmController.value.text
      ..district = districtConfirmController.value.text
      ..isAdmin = "false"
      ..isAdminFor = "";
    UserService service = UserService();
    var result = await service.register(user);
    return result;
  }

  @override
  void initState() {
    bloodGroupConfirmController.text = BLOOD_GROUPS[0];
    districtConfirmController.text = DISTRICTS[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REGISTER'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  controller: nameController,
                  validator: validate,
                  decoration: InputDecoration(
                    labelText: 'NAME',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: ageConfirmController,
                  validator: validate,
                  decoration: InputDecoration(
                    labelText: 'AGE',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    labelText: 'EMAIL',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneController,
                  validator: validate,
                  decoration: InputDecoration(
                    labelText: 'PHONE NUMBER',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: villageConfirmController,
                  validator: validate,
                  decoration: InputDecoration(
                    labelText: 'VILLAGE',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: districtConfirmController.text,
                  items: DISTRICTS.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      districtConfirmController.text = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                DropdownButton<String>(
                  value: bloodGroupConfirmController.text,
                  items: BLOOD_GROUPS.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      bloodGroupConfirmController.text = value;
                    });
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validate,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'PASSWORD',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  validator: validate,
                  controller: passwordConfirmController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'CONFIRM PASSWORD',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text('REGISTER'),
                    onPressed: () async {
                      if (passwordController.value.text !=
                          passwordConfirmController.value.text) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Passwords are not the same')));
                        return;
                      } else if (_formKey.currentState.validate()) {
                        var result = await _register();
                        if (result) {
                          Navigator.pop(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("something went wrong")));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Please Fill In all fields')));
                      }
                    },
                  ),
                ),
                Divider(),
                TextButton(onPressed: () {}, child: Text('CANCEL'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
