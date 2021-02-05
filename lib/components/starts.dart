import 'package:flutter/material.dart';

class RatingStarts extends StatelessWidget {
  const RatingStarts(this.number);
  final double number;
  @override
  Widget build(BuildContext context) {
    List<Widget> icons = List.generate(5, (i) =>  Icon(Icons.star, color: i < this.number ? Colors.brown : Colors.grey, size: 15,));
    return Row(
      children: icons,
    );
  }
}