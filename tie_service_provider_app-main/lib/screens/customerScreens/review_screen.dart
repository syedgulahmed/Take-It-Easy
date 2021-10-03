import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/design_assets/profile_cards/order_item_card.dart';
import 'package:tie_service_provider_app/design_assets/primary_button.dart';
import 'package:tie_service_provider_app/model/order_item.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReveiwScreen extends StatelessWidget {
  final OrderItem order;

  const ReveiwScreen({
    @required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leave Review'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OrderItemCard(order: order),
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
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            FractionallySizedBox(
              widthFactor: 0.4,
              child: PrimaryButton(
                name: 'Submit',
                color: Colors.blueAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
