import 'package:bw_blood_final/constants/routes.dart';
import 'package:bw_blood_final/services/user_service.dart';
import 'package:bw_blood_final/utils/validator.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAdmin = false;

  Future<bool> _login() async {
    var result = await UserService()
        .login(emailController.value.text.trim(), passwordController.value.text);
    return result;
  }

  _loginAsAdmin() async {
    var result = await UserService().loginAsAdmin(
        emailController.value.text, passwordController.value.text);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: emailController,
                      validator: validateEmail,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.mail,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: validatePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(
                          Icons.lock,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Checkbox(
                            value: _isAdmin,
                            onChanged: (value) {
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
                          if (_formKey.currentState.validate()) {
                            if (!_isAdmin) {
                              var result = await _login();
                              debugPrint(result.toString());
                              if (result) {
                                await Navigator.pushReplacementNamed(
                                    context, HOME_PAGE);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("something went wrong")));
                              }
                            } else {
                              var result = await _loginAsAdmin();
                              debugPrint(result.toString());
                              if (result) {
                                await Navigator.pushReplacementNamed(
                                    context, HOME_PAGE);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text("You are not an admin")));
                              }
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("something went wrong")));
                          }
                        },
                      ),
                    ),
                    Divider(),
                    TextButton(
                        onPressed: () async {
                          await Navigator.pushNamed(context, REGISTER_PAGE);
                        },
                        child: Text('Register'))
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
