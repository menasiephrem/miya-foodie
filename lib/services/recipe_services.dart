import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:foodie/models/recipe.dart';
import 'package:foodie/utils/general_util.dart';

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

Future<void> createRecipeDraft(Recipe recipe) async{
    await _fireStore.collection("recipes_drafts").doc(recipe.id).set(recipe.toJson());
}

Future<List<Recipe>> getAllRecipesDraft(String type) async{
    String user = await getLoggedInUser();
    List<Recipe> ret = [];
    QuerySnapshot snapshot = 
              await FirebaseFirestore.instance.
                     collection('recipes_drafts')
                     .where("type", isEqualTo: type)
                     .where("createdBy", isEqualTo: user)
                     .get();
    
    snapshot.docs.forEach((doc) {
       ret.add(new Recipe.fromData(doc.data()));
    });

    return ret;
}

Future<void> updateRecipeDraft(Recipe recipe) async{
    await _fireStore.collection("recipes_drafts").doc(recipe.id).set(recipe.toJson(), SetOptions(merge: true));
}

  
}