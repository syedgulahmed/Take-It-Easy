import 'package:flutter/material.dart';
import 'package:tie_customer_app/model/category.dart';
import 'package:tie_customer_app/model/serviceProvider.dart';

import 'customer.dart';

enum OrderStatus{REQUESTED, ACCEPTED, STARTED, FINISHED, PAST_ORDER}
class OrderItem {
  final String orderID;
  final Customer buyer;
  final ServiceProvider seller;
  final String startTime;
  final String endTime;
  final String address;
  final Category category;
  String description;
  OrderStatus orderStage;
  double rating;
  OrderItem(this.orderID, this.buyer, this.seller, this.startTime, this.endTime, this.category, this.rating, this.orderStage, this.address, this.description);
  void setRating(double rating){
    this.rating = rating;
  }
  void setOrderStatus(OrderStatus orderStatus){
    this.orderStage = orderStatus;
  }
  Map<String, dynamic> asMap(){
    return {
      "orderID": orderID,
      "buyer": buyer.asMap(),
      "seller": seller.asMap(),
      "address": address,
      "startTime": startTime,
      "endTime": endTime,
      "category": category.asMap(),
      "orderStatus": orderStage.toString(),
      "rating": rating,
      "description": description
    };
  }
}
