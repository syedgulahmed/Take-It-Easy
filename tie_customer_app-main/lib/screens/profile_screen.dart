import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tie_customer_app/main.dart';
import 'package:tie_customer_app/main_drawer.dart';
import 'package:tie_customer_app/design_assets/profile_picture.dart';
import 'package:tie_customer_app/design_assets/primary_button.dart';
import 'package:tie_customer_app/design_assets/main_button.dart';
import 'package:tie_customer_app/model/customer.dart';

class ProfileScreen extends StatelessWidget {
  static File _image;
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController number = new TextEditingController();
  TextEditingController address = new TextEditingController();
  TextEditingController pictureURL = new TextEditingController();
  static setImage(File image) {
    _image = image;
  }

  getUser() async {
    await MyApp.database.getCustomerByEmail().then((customer) {
      pictureURL.text = customer.imageUrl;
      name.text = customer.name;
      email.text = customer.email;
      number.text = customer.id;
      address.text = customer.address;
    });
  }

  Widget _entryField(String title, TextEditingController controller,
      {bool isPassword = false}) {
    return FractionallySizedBox(
      widthFactor: 0.8,
      child: TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ' + title + ' here';
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Enter ' + title,
              filled: true)),
    );
  }

  @override
  Widget build(BuildContext context) {
    MyApp.database.lock.synchronized(() {
      getUser();
    });
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Profile"),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
              ProfilePicture(
                pictureURL: pictureURL,
              ),
              SizedBox(
                height: 15,
              ),
              _entryField('Name', name),
              SizedBox(
                height: 15,
              ),
              _entryField('Email', email),
              SizedBox(
                height: 15,
              ),
              _entryField('Number', number),
              SizedBox(
                height: 15,
              ),
              _entryField('Address', address),
              SizedBox(
                height: 15,
              ),
              MainButton(
                name: 'Payment Settings',
                color: Colors.blue,
                widthSizePercent: 0.8,
                heightSizePixel: 50.0,
              ),
              SizedBox(
                height: 20,
              ),
              FractionallySizedBox(
                widthFactor: 0.8,
                child: Row(
                  children: [
                    PrimaryButton(
                      name: 'Cancel',
                      color: Colors.grey,
                      callback: () {
                        Navigator.of(context).pushReplacementNamed('home');
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    PrimaryButton(
                      name: 'Save',
                      color: Colors.blue,
                      callback: () {
                        MyApp.database.updateCustomer(new Customer(
                            number.text,
                            name.text,
                            email.text,
                            _image != null ? _image.path : "",
                            address.text));
                        Navigator.of(context).pushReplacementNamed('home');
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
