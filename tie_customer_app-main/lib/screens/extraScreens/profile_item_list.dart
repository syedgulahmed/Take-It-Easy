import 'package:flutter/material.dart';
import 'package:tie_customer_app/design_assets/profile_cards/profile_item_card.dart';
import 'package:tie_customer_app/model/category.dart';
import 'package:tie_customer_app/model/serviceProvider.dart';
import 'package:tie_customer_app/model/staticData.dart';

import '../../main.dart';

class ProfileListScreen extends StatelessWidget {
  final Category category;
  var myList = [];

  ProfileListScreen({
    @required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hire ' + category.title),
        backgroundColor: Colors.lightGreen,
      ),
      body: FutureBuilder<List<ServiceProvider>>(
          future: MyApp.database.getServiceProviders(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              for (int i = 0; i < snapshot.data.length; i++) {
                for (String c in snapshot.data[i].services) {
                  if (c == category.title) {
                    myList.add(snapshot.data[i]);
                  }
                }
              }
              return Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: myList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ProfileItemCard(
                          profileItem: myList[index],
                          service: category,
                        );
                      }));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
