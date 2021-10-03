import 'package:flutter/material.dart';
import 'package:tie_customer_app/design_assets/main_button.dart';
import 'package:tie_customer_app/design_assets/profile_cards/progress_order_item_card.dart';
import 'package:tie_customer_app/design_assets/timeline_tile.dart';
import 'package:tie_customer_app/main.dart';
import 'package:tie_customer_app/model/order_item.dart';
import 'package:tie_customer_app/screens/customerScreens/review_screen.dart';

class CustomerOrderProgressScreen extends StatelessWidget {
  const CustomerOrderProgressScreen({
    @required this.order,
  });

  final OrderItem order;
  int getWorkTime() {
    if (order.endTime != "") {
      var s = order.startTime.split(' ');
      var date = s[0].split('-');
      var time = s[1].split(':');
      DateTime start = DateTime(int.parse(date[2]), int.parse(date[1]),
          int.parse(date[0]), int.parse(time[1]), int.parse(time[0]));
      s = order.endTime.split(' ');
      date = s[0].split('-');
      time = s[1].split(':');
      DateTime end = DateTime(int.parse(date[2]), int.parse(date[1]),
          int.parse(date[0]), int.parse(time[1]), int.parse(time[0]));
      var duration = end.difference(start);
      return duration.inHours + 1;
    } else
      return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Progress'),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProgressOrderItemCard(order: order),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: 60,
                child: Center(
                  child: Text(
                    'Current status',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                    ),
                  ),
                ),
              ),
            ),
            CustomTimelineTile(
              title: 'Requested',
              isActive: (order.orderStage == OrderStatus.REQUESTED ||
                  order.orderStage == OrderStatus.ACCEPTED ||
                  order.orderStage == OrderStatus.STARTED ||
                  order.orderStage == OrderStatus.FINISHED ||
                  order.orderStage == OrderStatus.PAST_ORDER),
            ),
            CustomTimelineTile(
              title: 'Confirmed',
              isActive: (order.orderStage == OrderStatus.ACCEPTED ||
                  order.orderStage == OrderStatus.STARTED ||
                  order.orderStage == OrderStatus.FINISHED ||
                  order.orderStage == OrderStatus.PAST_ORDER),
            ),
            CustomTimelineTile(
              title: 'Started',
              isActive: (order.orderStage == OrderStatus.STARTED ||
                  order.orderStage == OrderStatus.FINISHED ||
                  order.orderStage == OrderStatus.PAST_ORDER),
              time: order.startTime,
              date: order.startTime,
            ),
            CustomTimelineTile(
              title: 'Finished',
              isActive: (order.orderStage == OrderStatus.FINISHED ||
                  order.orderStage == OrderStatus.PAST_ORDER),
              time: order.endTime,
              date: order.endTime,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    child: Container(
                      height: 100,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Work Time',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            order.endTime == ""
                                ? 'Not Completed Yet'
                                : getWorkTime().toString() + ' Hours',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      height: 70,
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Total Cost',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                            ),
                          ),
                          Text(
                            'Rs. ' +
                                (int.parse(order.seller.fees) * getWorkTime())
                                    .toString() +
                                '/-',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.indigoAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: (order.orderStage == OrderStatus.ACCEPTED)
                  ? MainButton(
                      name: 'Cancel Order',
                      color: Colors.blue,
                      widthSizePercent: 0.8,
                      heightSizePixel: 50.0,
                      callback: () async {
                        await MyApp.database.deleteOrder(order);
                        while (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        Navigator.of(context).pushReplacementNamed('home');
                      },
                    )
                  : Container(),
            ),
            Container(
              child: (order.orderStage == OrderStatus.FINISHED)
                  ? MainButton(
                      name: 'Leave Review',
                      color: Colors.blue,
                      widthSizePercent: 0.8,
                      heightSizePixel: 50.0,
                      callback: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReveiwScreen(order: order),
                            ));
                      },
                    )
                  : Container(),
            ),
            Container(
              child: (order.orderStage == OrderStatus.PAST_ORDER)
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (var i = 0; i < order.rating; i++)
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 40,
                          ),
                        for (var i = order.rating; i < 5; i++)
                          Icon(
                            Icons.star,
                            color: Colors.grey,
                            size: 40,
                          ),
                      ],
                    )
                  : Container(),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
