import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/model/order_item.dart';

class ProgressOrderItemCard extends StatelessWidget {
  final OrderItem order;
  VoidCallback callback;
  ProgressOrderItemCard({
    @required this.order, this.callback
  });

  @override
  Widget build(BuildContext context) {
    String name, imageURL, category;

    name = order.buyer.name;
    imageURL = order.buyer.imageUrl;
    category = "New Buyer";

    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        onTap: (){
          callback();
        },
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
