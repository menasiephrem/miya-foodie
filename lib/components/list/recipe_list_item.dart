import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/recipe.dart';
import 'package:foodie/pages/recipe_detail_page.dart';

import '../starts.dart';

class RecipeListItem extends StatelessWidget {
  const RecipeListItem(this.recipe);
  final Recipe recipe;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipeDetailPage(this.recipe))
            );
          },
          child: Row(
          children: [
            CachedNetworkImage(
                width: 100,
                height: 70,
                imageUrl: this.recipe.img,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:[
                Text(
                  this.recipe.name,
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800, fontSize: 18)
                ),
                Text(
                  this.recipe.description,
                  style: TextStyle(color: Colors.grey, fontSize: 12)
                ),
                RatingStarts(this.recipe.voteCount > 0? this.recipe.rating/this.recipe.voteCount: 0)
              ]
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  "${this.recipe.voteCount}",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)
                ),
                Text(
                  "Votes",
                  style: TextStyle(color: Colors.grey, fontSize: 12)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}