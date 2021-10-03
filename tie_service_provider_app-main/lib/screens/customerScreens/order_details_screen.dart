import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/design_assets/information_card.dart';
import 'package:tie_service_provider_app/design_assets/primary_button.dart';
import 'package:tie_service_provider_app/model/order_item.dart';

import '../../main.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({this.order});

  final OrderItem order;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Details'),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: NetworkImage(this.order.buyer.imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Text(
                this.order.buyer.name,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              InformationCard(
                title: 'Issue',
                description: this.order.description,
              ),
              InformationCard(
                title: 'Address',
                description: this.order.address,
              ),
              InformationCard(
                title: 'Job time',
                description:
                    '${this.order.startTime}, ${this.order.endTime == "" ? 'Not Yet Completed' : order.endTime}',
              ),
              SizedBox(
                height: 20,
              ),
              (order.orderStage == OrderStatus.REQUESTED)
                  ? Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Row(
                          children: [
                            PrimaryButton(
                              name: 'Reject',
                              color: Colors.grey,
                              callback: () async {
                                await MyApp.database.deleteOrder(order);
                                while (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                                Navigator.of(context)
                                    .pushReplacementNamed('home');
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            PrimaryButton(
                              name: 'Accept',
                              color: Colors.blue,
                              callback: () async {
                                order.setOrderStatus(OrderStatus.ACCEPTED);
                                await MyApp.database.updateOrder(order);
                                while (Navigator.canPop(context)) {
                                  Navigator.pop(context);
                                }
                                Navigator.of(context)
                                    .pushReplacementNamed('home');
                              },
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
