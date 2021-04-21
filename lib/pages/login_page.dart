import 'package:bw_blood_final/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isAdmin = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.mail,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(
                    Icons.lock,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Row(
                children: [
                  Checkbox(value: _isAdmin, onChanged: (value){
                    setState(() {
                      _isAdmin = value;
                    });
                  }),
                  Text("Login As Admin")
                ],
              ),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('LOGIN'),
                  onPressed: () async {
                    await Navigator.pushReplacementNamed(context, HOME_PAGE);
                  },
                ),
              ),
              Divider(),
              TextButton(onPressed: () async{
                await Navigator.pushNamed(context, REGISTER_PAGE);
              }, child: Text('Register'))
            ],
          ),
        ),
      ),
    );
  }
}
