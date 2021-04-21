import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  bool _isAdmin = false;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'NAME',
                  border: OutlineInputBorder(),

                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'AGE',
                  border: OutlineInputBorder(),

                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'EMAIL',
                  border: OutlineInputBorder(),

                ),
              ),
              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'PHONE NUMBER',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'VILLAGE',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'DISTRICT',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20,),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'BLOOD GROUP',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'PASSWORD',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20,),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'CONFIRM PASSWORD',
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20,),

              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  child: Text('REGISTER'),
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                ),
              ),
              Divider(),
              TextButton(onPressed: (){}, child: Text('CANCEL'))
            ],
          ),
        ),
      ),
    );
  }
}
