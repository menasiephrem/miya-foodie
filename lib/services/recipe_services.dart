import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/models/recipe.dart';

class RecipeService {
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance; 

  Future<void> createRecipe(Recipe recipe) async{
    await _fireStore.collection("recipes").doc(recipe.id).set(recipe.toJson());
  }

  
}