import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance; 

  Future<void> createRecipe(Recipe recipe) async{
    await _fireStore.collection("recipes").doc(recipe.id).set(recipe.toJson());
  }

  Future<List<Recipe>> getAllRecipes(String type) async{
    List<Recipe> ret = [];
    QuerySnapshot snapshot = 
              await FirebaseFirestore.instance.
                     collection('recipes')
                     .where("type", isEqualTo: type)
                     .get();
    
    snapshot.docs.forEach((doc) {
       ret.add(new Recipe.fromData(doc.data()));
    });

    return ret;
}

  
}