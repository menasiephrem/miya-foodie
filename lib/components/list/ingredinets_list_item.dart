import 'package:flutter/material.dart';

class IngridientListItem extends StatelessWidget {
  const IngridientListItem(this.item, {Key key}): super(key: key);
  final String item;
  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}