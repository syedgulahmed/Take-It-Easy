import 'package:flutter/material.dart';
import 'package:tie_customer_app/main_drawer.dart';
import 'package:tie_customer_app/model/customer.dart';
import 'package:tie_customer_app/model/order_item.dart';
import 'package:tie_customer_app/model/staticData.dart';
import 'package:tie_customer_app/design_assets/profile_cards/order_item_card.dart';
import 'package:tie_customer_app/screens/customerScreens/order_progress_screen.dart';

import '../../main.dart';

class CustomerPastOrderScreen extends StatefulWidget {
  @override
  _CustomerPastOrderScreenState createState() =>
      _CustomerPastOrderScreenState();
}

class _CustomerPastOrderScreenState extends State<CustomerPastOrderScreen> {
  Customer customer;
  getCustomer() async {
    customer = await MyApp.database.getCustomerByEmail();
  }

  @override
  void initState() {
    getCustomer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text("Prevous Orders"),
        backgroundColor: Colors.lightGreen,
      ),
      body: FutureBuilder<List<OrderItem>>(
          future: MyApp.database.getOrders(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData) {
              List<OrderItem> orders = <OrderItem>[];
              for (OrderItem o in snapshot.data) {
                if (customer != null) {
                  if (o.orderStage == OrderStatus.PAST_ORDER) {
                    if (o.buyer.email == customer.email) {
                      orders.add(o);
                    }
                  }
                }
              }
              return Container(
                  child: ListView.builder(
                      padding: EdgeInsets.all(16.0),
                      itemCount: orders.length,
                      itemBuilder: (BuildContext context, int index) {
                        return OrderItemCard(
                          order: orders[index],
                          callback: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    CustomerOrderProgressScreen(
                                  order: orders[index],
                                ),
                              ),
                            );
                          },
                        );
                      }));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
