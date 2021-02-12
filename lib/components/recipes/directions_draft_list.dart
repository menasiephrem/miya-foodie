import 'package:flutter/material.dart';
import 'package:foodie/components/Inputs/input_detail.dart';
import 'package:foodie/components/Inputs/input_text_area.dart';
import 'package:foodie/components/list/directions_draft_list_item.dart';
import 'package:foodie/models/recipe.dart';

class DirectionDraft extends StatefulWidget {
  DirectionDraft(this.recipe, this.updateRecipe);
  
  final Recipe recipe;
  final Function updateRecipe;
  @override
  _DirectionDraftState createState() => _DirectionDraftState();
}

class _DirectionDraftState extends State<DirectionDraft> {

  Recipe _recipe;
  List<dynamic> _items = [];
  String name;
  String value;
  String _editNameString = "";
  String _editValueString = "";
  int _editIndex = -1;
  BuildContext _context;

  @override
  void initState() { 
    super.initState();
    setState(() {
      _recipe = this.widget.recipe;
      _items = this.widget.recipe.directions != null ? this.widget.recipe.directions : [];
    });
  }


void onReorder(int oldIndex, int newIndex) {
  if (newIndex > oldIndex) {
    newIndex -= 1;
  }
  var ing = _recipe.directions;
  var game = _items[oldIndex];
   ing.removeAt(oldIndex);
   ing.insert(newIndex, game);
  setState(() {
    _items = ing;
    _recipe.directions = ing;
  });
 this.widget.updateRecipe(_recipe);
}

void _addIng(){
  var des = _recipe.directions;
  Map de = Map();
  de['name'] = name != null ? name : "";
  de['value'] = value != null ? value: "";
  if(des != null){
    des.add(de);
  }else{
    des = [de];
  }
  setState(() {
    _recipe.directions = des;
    _items = des;
  });
  this.widget.updateRecipe(_recipe);
}

List<Widget> _addDirections(){
    return <Widget>[
      InputForm((ing) => {
                name = ing
              }, "Name*", value: _editNameString,),
      InputTextArea((ing) => {
        value = ing
      }, "Description*", value: _editValueString, lines: 2)
    ];
  }

  _showDialog({bool edit = false}) async {
      await showDialog<String>(
        context: _context,
        builder: (context){
          return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text("${edit? "EDIT" : "ADD"} Direction", style: TextStyle(color: Color(0xffa59671), fontWeight: FontWeight.bold,)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: _addDirections(),
          ),
          actions: <Widget>[
            FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.pop(context);
                }),
            FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  if(edit){
                    _editItemName();
                  }else{
                    _addIng();
                  }
                  Navigator.pop(context);
                })
          ],
        );
        },
      );
  }

  _editItem(int index) {
    Map name = _items[index];
    setState(() {
      _editNameString = name['name'];
      _editValueString = name['value'];
      _editIndex = index;
    });
   _showDialog(edit: true);
  }

  _deleteItem(int index) {
    var ing = _recipe.ingredients;
    ing.removeAt(index);
    setState(() {
      _recipe.ingredients = ing;
      _items = ing;
    });
    this.widget.updateRecipe(_recipe);
  }

  _editItemName(){
    var des = _recipe.directions;
    Map de = Map();
    de['name'] = name != null ? name : "";
    de['value'] = value != null ? value: "";
    des.removeAt(_editIndex);
    des.insert(_editIndex, de);
    setState(() {
      _recipe.directions = des;
      _items = des;
    });
    this.widget.updateRecipe(_recipe);
  }


  List<Widget> _buildItems(){
    List<Widget> ret = [];
    for(int i = 0 ; i < _items.length; i++){
      var item = _items[i];
      ret.add(DirectionDraftListItem(item, key: ValueKey(item), edit: _editItem, delete: _deleteItem, index: i));
    }
    return ret;
  }


  @override
  Widget build(BuildContext context) {
    setState(() {
      _context = context;
    });
    return Scaffold(
      body: ReorderableListView(
        onReorder: onReorder,
        children: _buildItems()
      ),
       floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          backgroundColor: Color(0xffa59671),
          onPressed: (){
            _showDialog();
          },
        )
    );
  }
}