import 'package:flutter/material.dart';
import 'package:tie_customer_app/model/customer.dart';
import 'package:tie_customer_app/model/order_item.dart';
import 'package:tie_customer_app/screens/customerScreens/requested_order_screen.dart';
import 'package:tie_customer_app/screens/customerScreens/started_order_screen.dart';

import '../../main.dart';
import '../../main_drawer.dart';
import 'accepted_order_screen.dart';
import 'finished_order_screen.dart';

class CustomerCurrentOrderScreen extends StatefulWidget {
  @override
  CustomerCurrentOrderScreenState createState() =>
      CustomerCurrentOrderScreenState();
}

class CustomerCurrentOrderScreenState extends State<CustomerCurrentOrderScreen>
    with SingleTickerProviderStateMixin {
  Customer serviceProvider;
  OrderStatus status;
  TabController _controller;
  getServiceProvider() async {
    serviceProvider = await MyApp.database.getCustomerByEmail();
  }

  @override
  void initState() {
    super.initState();
    getServiceProvider();
    _controller = TabController(length: 4, vsync: this);
    _controller.addListener(() {
      setState(() {
        if (_controller.index == 0) {
          getServiceProvider();
          status = OrderStatus.ACCEPTED;
        } else if (_controller.index == 1) {
          getServiceProvider();
          status = OrderStatus.REQUESTED;
        } else if (_controller.index == 2) {
          getServiceProvider();
          status = OrderStatus.STARTED;
        } else if (_controller.index == 3) {
          getServiceProvider();
          status = OrderStatus.FINISHED;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 4,
      child: Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          title: Text('Current Orders'),
          backgroundColor: Colors.lightGreen,
          bottom: TabBar(
            controller: _controller,
            tabs: [
              Tab(text: 'Accepted'),
              Tab(text: 'Requested'),
              Tab(text: 'Started'),
              Tab(text: 'Finished'),
            ],
          ),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            AcceptedCurrentOrderScreen(
              customer: serviceProvider,
              status: status,
            ),
            AcceptedCurrentOrderScreen(
              customer: serviceProvider,
              status: status,
            ),
            AcceptedCurrentOrderScreen(
              customer: serviceProvider,
              status: status,
            ),
            AcceptedCurrentOrderScreen(
              customer: serviceProvider,
              status: status,
            ),
          ],
        ),
      ),
    );
  }
}
