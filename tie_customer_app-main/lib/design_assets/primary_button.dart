import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final Color color;
  final String name;
  final VoidCallback callback;

  const PrimaryButton({this.color, this.name, this.callback});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          callback();
        },
        child: Text(name),
        style: ElevatedButton.styleFrom(
          primary: color,
        ),
      ),
    );
  }
}
