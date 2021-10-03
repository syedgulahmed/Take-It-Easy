import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_screen.dart';
import 'main.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  logoutUser(BuildContext context) {
    final User user = MyApp.database.getAuth().currentUser;
    if (user == null) {
      Scaffold.of(context).showSnackBar(const SnackBar(
        content: Text('No one has signed in.'),
      ));
      return;
    }
    MyApp.database.getAuth().signOut();
    while (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    Navigator.of(context).pushReplacementNamed('logout');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 200,
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
              alignment: Alignment.centerLeft,
              color: Colors.white,
              child: Center(
                child: Image.asset('assets/logo.png'),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            buildListTile('Home', Icons.home, () {
              Navigator.of(context).pushReplacementNamed('home');
            }),
            buildListTile('Profile', Icons.account_circle_sharp, () {
              Navigator.of(context).pushReplacementNamed('profile');
            }),
            buildListTile('Current Order', Icons.text_snippet_outlined, () {
              Navigator.of(context).pushReplacementNamed('currentOrders');
            }),
            buildListTile('Past Orders', Icons.table_rows, () {
              Navigator.of(context).pushReplacementNamed('pastOrders');
            }),
            buildListTile('Addresses', Icons.add_location_alt_outlined, () {
              Navigator.of(context).pushReplacementNamed('addresses');
            }),
            buildListTile('Settings', Icons.settings, () {
              Navigator.of(context).pushReplacementNamed('settings');
            }),
            buildListTile('Logout', Icons.logout, () {
              logoutUser(context);
            }),
          ],
        ),
      ),
    );
  }
}
