import 'package:bw_blood_final/constants/routes.dart';
import 'package:flutter/material.dart';

Widget mainDrawer(BuildContext context) {
  return Drawer(
      child: ListView(
    children: [
      DrawerHeader(child: Center(
        // child: Text('BW BLOOD SERVICES'),
      )),
      ListTile(
        leading: Icon(
          Icons.home,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Home'),
        onTap: () async {
          await Navigator.pushReplacementNamed(context, HOME_PAGE);
          // Navigator.pop(context);
        },
      ),
      ListTile(
        leading: Icon(
          Icons.people,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Donors'),
        onTap: () async {
          await Navigator.pushReplacementNamed(context, DONORS_PAGE);
          // Navigator.pop(context);
        },
      ),
      ListTile(
          leading: Icon(
            Icons.calendar_today,
            color: Theme.of(context).primaryColor,
          ),
          title: Text('Appointments'),
          onTap: () async {
            await Navigator.pushReplacementNamed(context, APPOINTMENTS_PAGE);
            // Navigator.pop(context);
          }),
      ListTile(
          leading: Icon(
            Icons.business_center,
            color: Theme.of(context).primaryColor,
          ),
          title: Text('Blood Transfusion Centre'),
          onTap: () async {
            await Navigator.pushReplacementNamed(context, BTC_PAGE);
            // Navigator.pop(context);
          }),
      ListTile(
          leading: Icon(
            Icons.person,
            color: Theme.of(context).primaryColor,
          ),
          title: Text('Profile'),
          onTap: () async {
            await Navigator.pushReplacementNamed(context, PROFILE_PAGE);
            // Navigator.pop(context);
          }),
      ListTile(
        leading: Icon(
          Icons.logout,
          color: Theme.of(context).primaryColor,
        ),
        title: Text('Logout'),
      ),
    ],
  ));
}
