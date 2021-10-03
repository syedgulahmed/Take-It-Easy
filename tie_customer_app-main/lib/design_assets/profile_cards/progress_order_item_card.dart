import 'package:flutter/material.dart';
import 'package:tie_customer_app/model/order_item.dart';

class ProgressOrderItemCard extends StatelessWidget {
  final OrderItem order;

  ProgressOrderItemCard({
    @required this.order,
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
        trailing: OutlinedButton(
          onPressed: () {},
          child: Text('Chat'),
        ),
      ),
    );
  }
}
