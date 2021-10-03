import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tie_customer_app/design_assets/profile_cards/order_item_card.dart';
import 'package:tie_customer_app/design_assets/primary_button.dart';
import 'package:tie_customer_app/main.dart';
import 'package:tie_customer_app/model/order_item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReveiwScreen extends StatelessWidget {
  final OrderItem order;
  double rating = 0;
  ReveiwScreen({
    @required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Review'),
        backgroundColor: Colors.lightGreen,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            RatingBar(
              minRating: 1,
              maxRating: 5,
              direction: Axis.horizontal,
              allowHalfRating: false,
              itemCount: 5,
              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
              ratingWidget: RatingWidget(
                full: Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                empty: Icon(
                  Icons.star,
                  color: Colors.grey,
                ),
                half: Icon(
                  Icons.ac_unit,
                ),
              ),
              onRatingUpdate: (r) {
                rating = r;
              },
            ),
            SizedBox(
              height: 20,
            ),
            OrderItemCard(order: order),
            FractionallySizedBox(
              widthFactor: 0.8,
              child: PrimaryButton(
                name: 'Submit',
                color: Colors.blueAccent,
                callback: () {
                  order.setRating(rating);
                  order.setOrderStatus(OrderStatus.PAST_ORDER);
                  MyApp.database.updateOrder(order);
                  order.seller.numberOfOrders = order.seller.numberOfOrders + 1;
                  order.seller.currentReview =
                      order.seller.currentReview + rating;
                  MyApp.database.updateServiceProvider(order.seller);
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.of(context).pushReplacementNamed('home');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
