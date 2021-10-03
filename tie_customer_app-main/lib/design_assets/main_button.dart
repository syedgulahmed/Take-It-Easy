import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  final Color color;
  final String name;
  final double widthSizePercent;
  final double heightSizePixel;
  final VoidCallback callback;

  const MainButton({
    this.color,
    this.name,
    this.widthSizePercent,
    this.heightSizePixel,
    this.callback,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthSizePercent,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: color,
          minimumSize: Size(0, heightSizePixel),
        ),
        onPressed: callback,
        child: Text(name),
      ),
    );
  }
}
