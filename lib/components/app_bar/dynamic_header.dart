import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodie/models/recipe.dart';

class MyDynamicHeader extends SliverPersistentHeaderDelegate {
  int index = 0;
  MyDynamicHeader(this.recipe, this.actions);
  final Recipe recipe;
  final List<Widget> actions;
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            width: MediaQuery.of(context).size.width, 
            decoration: BoxDecoration(
              image: DecorationImage(
                image: CachedNetworkImageProvider(this.recipe.img),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.17), BlendMode.srcOver),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 1), // changes position of shadow
                ),
              ],
            ),
            child: Stack(
              children: [
                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX:  0, sigmaY: 0),
                  child: Container(
                    decoration: BoxDecoration(color: Colors.white.withOpacity(0)),
                  ),
                ),
                AppBar(
                          title: Text("Back"),
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                          actions: actions
                        )
              ],
            ),
          );
        }
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate _) => true;

  @override
  double get maxExtent => 400.0;

  @override
  double get minExtent => 80.0;
}