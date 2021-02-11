import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/recipe.dart';
import 'package:foodie/pages/recipe_draft_page.dart';
import 'package:foodie/utils/general_util.dart';

import '../starts.dart';

class RecipeDraftListItem extends StatelessWidget {
  const RecipeDraftListItem(this.recipe);
  final Recipe recipe;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => RecipeDraftPage(this.recipe))
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
                  prepareDesc(this.recipe.description, 40),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: Colors.grey, fontSize: 12)
                ),
                RatingStarts(this.recipe.voteCount > 0? this.recipe.rating/this.recipe.voteCount: 0)
              ]
            ),
            Spacer(),
            Column(
              children: [
                Text(
                  "Draft",
                  style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 16)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}