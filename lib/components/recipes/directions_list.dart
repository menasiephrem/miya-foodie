import 'package:flutter/material.dart';
import 'package:foodie/components/list/directions_list_item.dart';


class Directions extends StatelessWidget {
  const Directions(this.directions);
  final List<Map<String, String>> directions;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.directions.length,
        itemBuilder: (con, index) {
          return DirectionsListItem(directions[index]['title'], directions[index]['step'], index);
        },
      ),
    );
  }
}