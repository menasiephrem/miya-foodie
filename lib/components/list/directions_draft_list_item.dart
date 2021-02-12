import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class DirectionDraftListItem extends StatelessWidget {
  const DirectionDraftListItem(this.item,  {Key key, this.index, this.edit, this.delete}): super(key: key);
  final Map<dynamic, dynamic> item;
  final Function edit;
  final Function delete;
  final int index;
  @override
  Widget build(BuildContext context) {
    return  Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                    CircleAvatar(
                      radius: 13,
                      backgroundColor: Color(0xffa59671),
                      child: Center(
                        child: Text(
                          "${this.index + 1}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      this.item['name'],
                      style: TextStyle(color:  Color(0xffa59671), fontSize: 15, fontWeight: FontWeight.w600),
                    )
                ],
              ),
              SizedBox(height: 10),
              Text(
                this.item['value'],
                style: TextStyle(color: Colors.black, fontSize: 13, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 10),
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