import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:tie_customer_app/main.dart';
import 'package:tie_customer_app/screens/customerScreens/home_screen.dart';

import 'login_screen.dart';

class Splash extends StatelessWidget {
  Splash();

  bool _isLoggedIn = false;
  checkUser(BuildContext context){
    final User user = MyApp.database.getAuth().currentUser;
    if (user == null) {
      return;
    }
    else{
      _isLoggedIn = true;
      return;
    }
  }
  @override
  Widget build(BuildContext context) {
    checkUser(context);
    return AnimatedSplashScreen(
      splash: Image.asset(
        "assets/logo.png"),
      nextScreen:
          (_isLoggedIn) ? CustomerHome() : LoginScreen(),
      splashTransition: SplashTransition.sizeTransition,
      duration: 100,
    );
  }
}
