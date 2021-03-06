import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:foodie/components/list/recipe_list_item.dart';
import 'package:foodie/models/recipe.dart';

class AllRecipes extends StatelessWidget {
  const AllRecipes(this.type);
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.
            collection("recipes")
            .where("type", isEqualTo: type)
            .snapshots(),
        builder: (context, snapshot) {
        return !snapshot.hasData
            ?  Center(
                  child: Container(
                    color: Colors.white,
                    child: Center(child: CircularProgressIndicator(),
                    ),
                  ),
                )
            : ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (con, index) {
                  Recipe recipeData = new Recipe.fromData(snapshot.data.documents[index].data());
                  return RecipeListItem(recipeData);
                },
              );
          },
        ),
    );
  }
}