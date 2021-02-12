import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class IngridientDraftListItem extends StatelessWidget {
  const IngridientDraftListItem(this.item, {Key key, this.index, this.edit, this.delete}): super(key: key);
  final String item;
  final Function edit;
  final Function delete;
  final int index;
  @override
  Widget build(BuildContext context) {
    return  Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
        color: Colors.grey[100],
        margin: EdgeInsets.symmetric(horizontal: 30),
        height: 50,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              item,
              style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
            ),
            Spacer(),
            Divider(height: 5, color: Colors.black54,), 
          ],
        ),
      ),
      actions: 
        [
          IconSlideAction(
              caption: 'Edit',
              color: Colors.green,
              icon: Icons.edit,
              onTap: (){
                edit(index);
              },
          ),
          IconSlideAction(
            caption: 'Delete',
            color: Colors.red,
            icon: Icons.delete,
            onTap:(){
              delete(index);
            },
          )
        ]  
      );
  }
}