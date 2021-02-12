import 'package:flutter/material.dart';
import 'package:foodie/components/list/ingredinets_list_item.dart';
import 'package:foodie/models/recipe.dart';

class IngredientsDraft extends StatefulWidget {
  IngredientsDraft(this.recipe, this.updateRecipe);
  
  final Recipe recipe;
  final Function updateRecipe;
  @override
  _IngredientsDraftState createState() => _IngredientsDraftState();
}

class _IngredientsDraftState extends State<IngredientsDraft> {

  Recipe _recipe;
  List<String> _items = [];

  @override
  void initState() { 
    super.initState();
    setState(() {
      _recipe = this.widget.recipe;
      _items = this.widget.recipe.ingredients != null ? this.widget.recipe.ingredients : [];
    });
  }


void onReorder(int oldIndex, int newIndex) {
  if (newIndex > oldIndex) {
    newIndex -= 1;
  }
  String game = _items[oldIndex];

  setState(() {
    _items.removeAt(oldIndex);
    _items.insert(newIndex, game);
    _recipe.ingredients = _items;
  });
 this.widget.updateRecipe(_recipe);
}

  @override
  Widget build(BuildContext context) {
    return ReorderableListView(
        onReorder: (int oldIndex, int newIndex) {},
        children: _items
                  .asMap().map((i, item) => MapEntry(i, IngridientListItem("${i + 1} - $item")))
                  .values
                  .toList(),
      );
  }
}