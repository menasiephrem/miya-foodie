import 'package:flutter/material.dart';
import 'package:foodie/components/list/ingredinets_list_item.dart';

class Ingredients extends StatelessWidget {
  const Ingredients(this.ingredients);
  final List<dynamic> ingredients;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: this.ingredients.length,
        itemBuilder: (con, index) {
          return IngridientListItem("${index + 1} - ${this.ingredients[index]}");
        },
      ),
    );
  }
}