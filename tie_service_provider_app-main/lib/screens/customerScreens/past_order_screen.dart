import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/main_drawer.dart';
import 'package:tie_service_provider_app/model/order_item.dart';
import 'package:tie_service_provider_app/model/serviceProvider.dart';
import 'package:tie_service_provider_app/model/staticData.dart';
import 'package:tie_service_provider_app/design_assets/profile_cards/order_item_card.dart';
import 'package:tie_service_provider_app/screens/customerScreens/order_progress_screen.dart';

import '../../main.dart';

class CustomerPastOrderScreen extends StatefulWidget {
  @override
  _CustomerPastOrderScreenState createState() =>
      _CustomerPastOrderScreenState();
}

class _CustomerPastOrderScreenState extends State<CustomerPastOrderScreen> {
  ServiceProvider serviceProvider;
  getServiceProvider() async {
    serviceProvider = await MyApp.database.getServiceProviderByEmail();
  }

  @override
  void initState() {
    getServiceProvider();
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
                if (serviceProvider != null) {
                  if (o.orderStage == OrderStatus.PAST_ORDER) {
                    if (o.seller.email == serviceProvider.email) {
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
