import 'package:flutter/material.dart';
import 'package:foodie/components/list/directions_list_item.dart';


class Directions extends StatelessWidget {
  const Directions(this.directions);
  final Map<dynamic, dynamic> directions;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.directions.keys.length,
        itemBuilder: (con, index) {
          var key = this.directions.keys.toList()[index];
          return DirectionsListItem(key, this.directions[key], index);
        },
      ),
    );
  }
}