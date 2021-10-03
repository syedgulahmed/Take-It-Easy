import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/main.dart';
import 'package:tie_service_provider_app/model/customer.dart';
import 'package:tie_service_provider_app/screens/customerScreens/current_order_screen.dart';
import 'package:tie_service_provider_app/screens/customerScreens/home_screen.dart';

import 'model/serviceProvider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen();

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isChecked = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  bool _success = false;
  String _userEmail;
  void _register() async {
    await MyApp.database.lock.synchronized(() async {
      final User user =
          (await MyApp.database.getAuth().createUserWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  ))
              .user;
      if (user != null) {
        setState(() {
          _success = true;
          _userEmail = user.email;
        });
      } else {
        setState(() {
          _success = false;
        });
      }
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
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                    child: Image(
                      width: 300,
                      image: AssetImage('assets/logo.png'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: _entryField('Name', name),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: _entryField('Email', email),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: _entryField('Mobile', phone),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: _entryField('Password', password, isPassword: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: _entryField('Confirm Password', confirmPassword,
                        isPassword: true),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: Row(
                        children: [
                          Checkbox(
                            value: isChecked,
                            onChanged: (bool value) {
                              setState(() {
                                isChecked = value;
                              });
                            },
                          ),
                          Text('I accept all terms and conditions.')
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            if (isChecked) {
                              await MyApp.database.lock.synchronized(() async {
                                _register();
                              });
                              await MyApp.database.lock.synchronized(() async {
                                if (_success) {
                                  Navigator.pop(context);
                                  MyApp.database.insertServiceProvider(
                                      new ServiceProvider(phone.text, name.text,
                                          email.text, "", "", "", [], 0, 0));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerCurrentOrderScreen()),
                                  );
                                }
                              });
                            }
                          }
                        },
                        child: Text(
                          'Sign Up',
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.blueGrey,
                          minimumSize: Size(300, 50.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
                    child: FractionallySizedBox(
                      widthFactor: 0.8,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Login',
                        ),
                        style: OutlinedButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.lightGreen,
                          minimumSize: Size(300, 50.0),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
