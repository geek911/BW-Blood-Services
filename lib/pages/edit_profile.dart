
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/utils/validator.dart';
import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
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



  Future<bool> _update(){
    return Future.value(false);
  }

  @override
  void initState() {
    UserService().currentApplicationUser.then((user){
      setState(() {
        nameController.text = user.name;
        ageConfirmController.text = user.age;
        emailController.text = user.email;
        phoneController.text = user.phone;
        villageConfirmController.text = user.village;
        districtConfirmController.text = user.district;
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Scaffold(
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
                    TextFormField(
                      validator: validate,
                      controller: districtConfirmController,
                      decoration: InputDecoration(
                        labelText: 'DISTRICT',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: validateBloodGroup,
                      controller: bloodGroupConfirmController,
                      decoration: InputDecoration(
                        labelText: 'BLOOD GROUP',
                        border: OutlineInputBorder(),
                      ),
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
                        child: Text('UPDATE'),
                        onPressed: () async {
                          if (passwordController.value.text !=
                              passwordConfirmController.value.text) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('Passwords are not the same')));
                            return;
                          } else if (_formKey.currentState.validate()) {
                            var result = await _update();
                            if (result) {
                              Navigator.pop(context);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text("something went wrong")));
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
        ),
      ),
    );
  }
}

