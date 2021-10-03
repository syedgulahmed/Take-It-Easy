import 'package:flutter/material.dart';
import 'package:tie_customer_app/main_drawer.dart';
import 'package:tie_customer_app/design_assets/editable_text_field.dart';
import 'package:tie_customer_app/design_assets/primary_button.dart';
import 'package:tie_customer_app/design_assets/main_button.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          children: [
            EditableTextField(
              labelName: 'Language',
              value: 'English',
              editable: true,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: SwitchListTile(
                title: Text('Push Notification'),
                value: false,
                onChanged: (bool value) => {},
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            MainButton(
              name: 'Change Password',
              color: Colors.blue,
              widthSizePercent: 0.8,
              heightSizePixel: 50.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            MainButton(
              name: 'About App',
              color: Colors.blue,
              widthSizePercent: 0.8,
              heightSizePixel: 50.0,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 20,
            ),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: Row(
                children: [
                  PrimaryButton(
                    name: 'Cancel',
                    color: Colors.grey,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PrimaryButton(
                    name: 'Save',
                    color: Colors.blue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
