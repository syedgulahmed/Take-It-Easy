import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tie_customer_app/main_drawer.dart';
import 'package:tie_customer_app/design_assets/editable_text_field.dart';
import 'package:tie_customer_app/design_assets/primary_button.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tie_customer_app/model/customer.dart';

import '../main.dart';

class AddressesScreen extends StatefulWidget {
  AddressesScreen({Key key}) : super(key: key);
  @override
  AddressesScreenState createState() => AddressesScreenState();
}

class AddressesScreenState extends State<AddressesScreen> {
  Geolocator geolocator = Geolocator();

  Position userGeoLocation;
  GoogleMapController _controller;
  Position _currentPosition;
  String _currentAddress = '';
  String _address, _dateTime;
  var location = new Location();
  Map<String, double> userLocation;
  LatLng _center = LatLng(0.5937, 0.9629);
  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  _getCurrentLocation() {
    Geolocator.getCurrentPosition(forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        _currentPosition = position;
        _center = LatLng(_currentPosition.latitude, _currentPosition.longitude);
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress =
            "${place.street}, ${place.subLocality}, ${place.locality}, ${place.subAdministrativeArea}, ${place.administrativeArea}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _controller = controller;
    _getCurrentLocation();
    _controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: _center,
        zoom: 15,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Addresses"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(target: _center, zoom: 15),
              mapType: MapType.normal,
              markers: <Marker>{
                Marker(markerId: MarkerId('myLoc'), position: _center)
              },
              myLocationEnabled: true,
            ),
          ),
          EditableTextField(
            labelName: 'Address',
            value: _currentAddress,
            editable: true,
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
          ),
          EditableTextField(
            labelName: 'Note',
            value: 'Nothing just arrive on time and call me',
            editable: true,
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
                  callback: () async {
                    Customer customer =
                        await MyApp.database.getCustomerByEmail();
                    MyApp.database.updateCustomer(new Customer(
                        customer.id,
                        customer.name,
                        customer.email,
                        customer.imageUrl,
                        _currentAddress));
                    Navigator.of(context).pushReplacementNamed('home');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
