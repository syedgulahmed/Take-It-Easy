import 'package:flutter/material.dart';
import 'package:tie_customer_app/main_drawer.dart';
import 'package:tie_customer_app/design_assets/category_card.dart';
import 'package:tie_customer_app/model/category.dart';
import 'package:tie_customer_app/model/customer.dart';
import 'package:tie_customer_app/model/staticData.dart';

import '../../main.dart';

class CustomerHome extends StatelessWidget {
  Widget cardItem() {
    return Container(
      child: FutureBuilder<List<Category>>(
          future: MyApp.database.getCategories(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              return Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return CategoryCard(title: snapshot.data[index]);
                      }));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Customer Home"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          cardItem(),
        ],
      )),
    );
  }
}
