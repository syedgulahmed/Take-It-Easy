import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tie_customer_app/model/database.dart';
import 'package:tie_customer_app/screens/addresses_screen.dart';
import 'package:tie_customer_app/screens/profile_screen.dart';
import 'package:tie_customer_app/screens/settings_screen.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:core';
import 'package:tie_customer_app/screens/customerScreens/home_screen.dart';
import 'package:tie_customer_app/screens/customerScreens/current_order_screen.dart';
import 'package:tie_customer_app/screens/customerScreens/past_order_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tie_customer_app/splash.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final bool isCustomer = true;
  static Database database = new Database();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Take It Easy',
      routes: <String, WidgetBuilder>{
        'home': (ctx) => CustomerHome(),
        'splash': (ctx) => Splash(),
        'profile': (ctx) => ProfileScreen(),
        'settings': (ctx) => SettingsScreen(),
        'currentOrders': (ctx) => CustomerCurrentOrderScreen(),
        'pastOrders': (ctx) => CustomerPastOrderScreen(),
        'addresses': (ctx) => AddressesScreen(),
        'logout': (ctx) => LoginScreen(),
      },
      initialRoute: 'splash',
    );
  }
}
