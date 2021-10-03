import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/design_assets/profile_cards/order_item_card.dart';
import 'package:tie_service_provider_app/model/order_item.dart';
import 'package:tie_service_provider_app/model/staticData.dart';

import '../../main.dart';
import 'order_progress_screen.dart';

class RequestedCurrentOrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderItem>>(
        future: MyApp.database.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            List<OrderItem> orders = <OrderItem>[];
            for (var o in snapshot.data) {
              if (o.orderStage == OrderStatus.REQUESTED) {
                orders.add(o);
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
                              builder: (context) => CustomerOrderProgressScreen(
                                order: orders[index],
                              ),
                            ),
                          );
                        },
                      );
                    }));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
