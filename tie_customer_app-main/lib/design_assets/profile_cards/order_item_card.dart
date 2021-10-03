import 'package:flutter/material.dart';
import 'package:tie_customer_app/model/order_item.dart';

class OrderItemCard extends StatelessWidget {
  final OrderItem order;
  final VoidCallback callback;

  OrderItemCard({
    @required this.order,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    String name, imageURL, category;

    name = order.seller.name;
    imageURL = order.seller.imageUrl;
    category = order.category.title;

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        onTap: callback,
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(imageURL),
              fit: BoxFit.fill,
            ),
          ),
        ),
        title: Text(
          name,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          category,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        trailing: Column(
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Row(
                children: [
                  Icon(Icons.access_time),
                  Text(this.order.startTime),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: Row(
                children: [
                  Icon(Icons.calendar_today),
                  Text(this.order.startTime),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
