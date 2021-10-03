import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final String title;
  final bool isActive;
  final String time;
  final String date;

  const CustomTimelineTile({
    this.title,
    this.isActive,
    this.time = "",
    this.date = "",
  }) : super();

  @override
  Widget build(BuildContext context) {
    Color contextColor = Colors.blueGrey;

    if (this.isActive) {
      contextColor = Colors.green;
    }

    return TimelineTile(
      startChild: SizedBox(
        height: 100,
        width: 100,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                this.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontStyle: FontStyle.italic,
                  color: contextColor,
                ),
              ),
            ],
          ),
        ),
      ),
      endChild: this.isActive
          ? SizedBox(
              height: 100,
              width: 100,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      this.time,
                      style: TextStyle(
                        color: Colors.blueGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(this.date,
                        style: TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        )),
                  ],
                ),
              ),
            )
          : null,
      alignment: TimelineAlign.center,
      beforeLineStyle: LineStyle(
        color: contextColor,
      ),
      indicatorStyle: IndicatorStyle(
        width: 40,
        color: contextColor,
        padding: const EdgeInsets.all(8),
        iconStyle: IconStyle(
          color: Colors.white,
          iconData: this.isActive ? Icons.check : Icons.circle,
        ),
      ),
    );
  }
}
