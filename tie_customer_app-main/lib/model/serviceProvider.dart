

import 'package:tie_customer_app/model/category.dart';

class ServiceProvider {
  final String id;
  final String name;
  final String email;
  final String imageUrl;
  final String address;
  final String fees;
  final List<dynamic> services;
  double currentReview;
  int numberOfOrders;

  ServiceProvider(this.id, this.name, this.email, this.imageUrl, this.address, this.fees, this.services, this.currentReview, this.numberOfOrders);
  Map<String, dynamic> asMap() => {
      "id": id,
      "name": name,
      "email": email,
      "image": imageUrl,
      "address": address,
      "fees": fees,
      "rating": currentReview,
      "numOfOrders": numberOfOrders,
      "services": services,
  };
}
