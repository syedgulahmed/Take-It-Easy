import 'package:flutter/material.dart';
import 'package:tie_customer_app/main.dart';
import 'package:tie_customer_app/model/category.dart';
import 'package:tie_customer_app/model/customer.dart';
import 'package:tie_customer_app/model/order_item.dart';
import 'package:tie_customer_app/model/serviceProvider.dart';
import 'package:tie_customer_app/screens/customerScreens/HiringScreen.dart';


class ProfileItemCard extends StatefulWidget{
  final ServiceProvider profileItem;
  final String status = 'notHired'; //notHired, requeseted, accepted
  final Category service;
  @override
  ProfileItemCard({
    @required this.profileItem, @required this.service,
  });

  @override
  ProfileItemCardState createState() => ProfileItemCardState();
}

class ProfileItemCardState extends State<ProfileItemCard> {



  Widget build(BuildContext context) {
    final ServiceProvider profileItem = widget.profileItem;
    final String status = widget.status; //notHired, requeseted, accepted
    final Category service = widget.service;
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HiringScreen(status: profileItem, category: service,),
            ),
          );
        },
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(profileItem.imageUrl), fit: BoxFit.fill),
          ),
        ),
        title: Text(
          profileItem.name,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
          (profileItem.fees + "/- per hour"),
        ),
        trailing: Column(
          children: <Widget>[
            Icon(
              Icons.star,
              color: Colors.yellow,
              size: 30.0,
            ),
            GestureDetector(
              child: Text("(" + profileItem.currentReview.toString() + ")")
            ),
          ],
        ),
      ),
    );
  }
}
