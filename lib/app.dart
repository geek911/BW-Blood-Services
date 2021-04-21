import 'package:bw_blood_final/constants/routes.dart';
import 'package:bw_blood_final/pages/appointment_page.dart';
import 'package:bw_blood_final/pages/btc_page.dart';
import 'package:bw_blood_final/pages/donors_page.dart';
import 'package:bw_blood_final/pages/home_page.dart';
import 'package:bw_blood_final/pages/login_page.dart';
import 'package:bw_blood_final/pages/profile_page.dart';
import 'package:bw_blood_final/pages/register_page.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: LOGIN_PAGE,
      routes: {
        LOGIN_PAGE: (context)=>LoginPage(),
        REGISTER_PAGE: (context)=>RegisterPage(),
        HOME_PAGE: (context)=> HomePage(),
        DONORS_PAGE: (context)=> DonorsPage(),
        APPOINTMENTS_PAGE: (context)=> AppointmentPage(),
        BTC_PAGE: (context)=>BTCPage(),
        PROFILE_PAGE: (context)=>ProfilePage()
      },

    );
  }
}
