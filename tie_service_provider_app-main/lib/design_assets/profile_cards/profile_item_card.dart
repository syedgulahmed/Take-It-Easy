import 'package:flutter/material.dart';
import 'package:tie_service_provider_app/model/customer.dart';
import 'package:tie_service_provider_app/model/serviceProvider.dart';
import 'package:tie_service_provider_app/screens/customerScreens/HiringScreen.dart';

class ProfileItemCard extends StatelessWidget {
  final ServiceProvider profileItem;
  final String status = 'notHired'; //notHired, requeseted, accepted
  final String service;
  @override
  ProfileItemCard({
    @required this.profileItem,
    @required this.service,
  });

  Widget build(BuildContext context) {
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
              builder: (context) => HiringScreen(status: profileItem),
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
            Text("(" + profileItem.address + ")"),
          ],
        ),
      ),
    );
  }
}
