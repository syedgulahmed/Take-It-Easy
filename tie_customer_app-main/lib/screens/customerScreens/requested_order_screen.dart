import 'package:flutter/material.dart';
import 'package:tie_customer_app/design_assets/profile_cards/order_item_card.dart';
import 'package:tie_customer_app/model/customer.dart';
import 'package:tie_customer_app/model/order_item.dart';
import 'package:tie_customer_app/model/staticData.dart';
import 'package:tie_customer_app/screens/customerScreens/order_progress_screen.dart';

import '../../main.dart';

class RequestedCurrentOrderScreen extends StatefulWidget{
  final Customer customer;

  const RequestedCurrentOrderScreen({Key key, this.customer}) : super(key: key);
  @override
  RequestedCurrentOrderScreenState createState() => RequestedCurrentOrderScreenState();
}

class RequestedCurrentOrderScreenState extends State<RequestedCurrentOrderScreen>{
  Future<List<OrderItem>> orderItems;
  @override
  void initState() {
    super.initState();
    orderItems = MyApp.database.getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<OrderItem>>(
        future: orderItems,
        builder: (context, snapshot) {
          if(snapshot.hasError){
            print(snapshot.error);
            return Center(child: CircularProgressIndicator());
          }
          else if (snapshot.hasData) {
            List<OrderItem> orders = <OrderItem>[];
            for(OrderItem o in snapshot.data){
              if(widget.customer != null){
                print(widget.customer.name);
                if(o.orderStage == OrderStatus.REQUESTED){
                  if(o.buyer.email == widget.customer.email){
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
                              builder: (context) => CustomerOrderProgressScreen(
                                order: orders[index],
                              ),
                            ),
                          );
                        },
                      );
                    }
                )
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

}
