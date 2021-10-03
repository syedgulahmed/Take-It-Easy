import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tie_service_provider_app/main.dart';
import 'package:tie_service_provider_app/main_drawer.dart';
import 'package:tie_service_provider_app/design_assets/profile_picture.dart';
import 'package:tie_service_provider_app/design_assets/primary_button.dart';
import 'package:tie_service_provider_app/design_assets/main_button.dart';
import 'package:tie_service_provider_app/model/customer.dart';
import 'package:tie_service_provider_app/model/category.dart';
import 'package:tie_service_provider_app/model/serviceProvider.dart';

class ProfileScreen extends StatefulWidget {
  static File _image;
  static List<dynamic> categoryList = [''];
  static setImage(File image) {
    _image = image;
  }

  static List<dynamic> getCategoryList() {
    return categoryList;
  }

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController name = new TextEditingController();

  TextEditingController email = new TextEditingController();

  TextEditingController number = new TextEditingController();

  TextEditingController address = new TextEditingController();

  TextEditingController fees = new TextEditingController();

  TextEditingController pictureURL = new TextEditingController();
  int numOfOrders = 0;
  double rating = 0;

  @override
  void initState() {
    getUser();
    super.initState();
  }

  getUser() async {
    await MyApp.database.getServiceProviderByEmail().then((employee) {
      pictureURL.text = employee.imageUrl;
      name.text = employee.name;
      email.text = employee.email;
      number.text = employee.id;
      address.text = employee.address;
      fees.text = employee.fees;
      employee.services.isEmpty
          ? ProfileScreen.categoryList = ['']
          : ProfileScreen.categoryList = employee.services;
      numOfOrders = employee.numberOfOrders;
      rating = employee.currentReview;
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

  List<Widget> _getFriends() {
    List<Widget> friendsTextFields = [];
    for (int i = 0; i < ProfileScreen.categoryList.length; i++) {
      friendsTextFields.add(Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Row(
          children: [
            Expanded(child: FriendTextFields(i)),
            SizedBox(
              width: 16,
            ),
            // we need add button at last friends row
            _addRemoveButton(i == ProfileScreen.categoryList.length - 1, i),
          ],
        ),
      ));
    }
    return friendsTextFields;
  }

  Widget _addRemoveButton(bool add, int index) {
    return InkWell(
      onTap: () {
        if (add) {
          // add new text-fields at the top of all friends textfields
          ProfileScreen.categoryList.insert(0, "");
        } else
          ProfileScreen.categoryList.removeAt(index);
        setState(() {});
      },
      child: Container(
        width: 30,
        height: 30,
        decoration: BoxDecoration(
          color: (add) ? Colors.green : Colors.red,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(
          (add) ? Icons.add : Icons.remove,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _numberEntryField(String title, TextEditingController controller,
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
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter ' + title,
                filled: true)));
  }

  @override
  Widget build(BuildContext context) {
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
              _numberEntryField('Fees', fees),
              SizedBox(
                height: 15,
              ),
              ..._getFriends(),
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
                        MyApp.database.updateServiceProvider(
                            new ServiceProvider(
                                number.text,
                                name.text,
                                email.text,
                                ProfileScreen._image != null
                                    ? ProfileScreen._image.path
                                    : "",
                                address.text,
                                fees.text,
                                ProfileScreen.categoryList,
                                rating,
                                numOfOrders));
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

class FriendTextFields extends StatefulWidget {
  final int index;
  FriendTextFields(this.index);
  @override
  _FriendTextFieldsState createState() => _FriendTextFieldsState();
}

class _FriendTextFieldsState extends State<FriendTextFields> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> cat = <String>[
    'Home Cleaning',
    'Electrician',
    'Plumbers',
    'Mechanic',
    'Home Movers',
    'Carpenters'
  ];

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
        widthFactor: 0.8,
        child: DropdownButtonFormField<String>(
          value: cat.contains(ProfileScreen.categoryList[widget.index])
              ? ProfileScreen.categoryList[widget.index]
              : null,
          icon: const Icon(Icons.arrow_downward),
          iconSize: 24,
          style: const TextStyle(color: Colors.black),
          hint: Text('Select Employee'),
          onChanged: (String value) {
            setState(() {
              ProfileScreen.categoryList[widget.index] = value ?? '';
            });
          },
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select Employee';
            }
            return null;
          },
          decoration: InputDecoration(border: InputBorder.none, filled: true),
          items: <String>[
            'Home Cleaning',
            'Electrician',
            'Plumbers',
            'Mechanic',
            'Home Movers',
            'Carpenter'
          ].map((mainItem) {
            return new DropdownMenuItem<String>(
              value: mainItem,
              child: Text(mainItem),
            );
          }).toList(),
        ));
  }
}
