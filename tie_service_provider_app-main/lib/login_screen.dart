import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/main.dart';
import 'package:tie_service_provider_app/model/serviceProvider.dart';
import 'package:tie_service_provider_app/screens/customerScreens/home_screen.dart';
import 'package:tie_service_provider_app/sign_up_screen.dart';

import 'screens/customerScreens/current_order_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen();

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool _success;
  String _userEmail;

  void _signInWithEmailAndPassword() async {
    await MyApp.database.lock.synchronized(() async {
      final User user =
          (await MyApp.database.getAuth().signInWithEmailAndPassword(
                    email: email.text,
                    password: password.text,
                  ))
              .user;

      if (user != null) {
        setState(() async {
          ServiceProvider serviceProvider = await MyApp.database.getServiceProviderByEmail();
          if(serviceProvider != null){
            _success = true;
            _userEmail = user.email;
          }
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Image(
                  width: 300,
                  image: AssetImage('assets/logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: [
                    Text(
                      'Welcome to Service Provider App',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    Text(
                      'Login to Continue',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: _entryField('Email', email),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child:
                            _entryField('Password', password, isPassword: true),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FractionallySizedBox(
                        widthFactor: 0.8,
                        child: OutlinedButton(
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await MyApp.database.lock.synchronized(() async {
                                _signInWithEmailAndPassword();
                              });
                              await MyApp.database.lock.synchronized(() async {
                                print(_success);
                                if (_success) {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CustomerCurrentOrderScreen()),
                                  );
                                }
                              });
                            }
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
                    ],
                  ),
                ),
              ),
              TextButton(
                onPressed: () => {},
                child: Text('Forgot Password ?'),
                style: TextButton.styleFrom(
                  primary: Colors.black,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                child: FractionallySizedBox(
                  widthFactor: 0.8,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpScreen()),
                      );
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
            ],
          ),
        ),
      ),
    );
  }
}
