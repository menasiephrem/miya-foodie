import 'package:flutter/material.dart';
import 'package:foodie/components/Inputs/input_detail.dart';
import 'package:foodie/components/list/Ingredinets_draft_list_item.dart';
import 'package:foodie/models/recipe.dart';

class IngredientsDraft extends StatefulWidget {
  IngredientsDraft(this.recipe, this.updateRecipe);
  
  final Recipe recipe;
  final Function updateRecipe;
  @override
  _IngredientsDraftState createState() => _IngredientsDraftState();
}

class _IngredientsDraftState extends State<IngredientsDraft> {

  Recipe _recipe;
  List<dynamic> _items = [];
  String _ingrident;
  String _editString = "";
  int _editIndex = -1;
  BuildContext _context;

  @override
  void initState() { 
    super.initState();
    setState(() {
      _recipe = this.widget.recipe;
      _items = this.widget.recipe.ingredients != null ? this.widget.recipe.ingredients : [];
    });
  }


void onReorder(int oldIndex, int newIndex) {
  if (newIndex > oldIndex) {
    newIndex -= 1;
  }
  var ing = _recipe.ingredients;
  String game = "${_items[oldIndex]}";
   ing.removeAt(oldIndex);
   ing.insert(newIndex, game);
  setState(() {
    _items = ing;
    _recipe.ingredients = ing;
  });
 this.widget.updateRecipe(_recipe);
}

void _addIng(){
  var ing = _recipe.ingredients;
  if(ing != null){
    ing.add(_ingrident);
  }else{
    ing = [_ingrident];
  }
  setState(() {
    _recipe.ingredients = ing;
    _items = ing;
  });
  this.widget.updateRecipe(_recipe);
}

List<Widget> _addIngredinet(){
    return <Widget>[
      Expanded(
        child: InputForm((ing) => {
            _ingrident = ing
          }, "Name*", value: _editString,),
      )
    ];
  }

  _showDialog({bool edit = false}) async {
      await showDialog<String>(
        context: _context,
        builder: (context){
          return AlertDialog(
          contentPadding: const EdgeInsets.all(16.0),
          title: Text("${edit? "EDIT" : "ADD"} Ingredient", style: TextStyle(color: Color(0xffa59671), fontWeight: FontWeight.bold,)),
          content: Row(
            children: _addIngredinet(),
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
    print(_items[index]);
    String name = _items[index];
    setState(() {
      _editString = name;
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
    var ing = _recipe.ingredients;
    ing.removeAt(_editIndex);
    ing.insert(_editIndex, _ingrident);
    setState(() {
      _recipe.ingredients = ing;
      _items = ing;
    });
    this.widget.updateRecipe(_recipe);
  }


  List<Widget> _buildItems(){
    List<Widget> ret = [];
    for(int i = 0 ; i < _items.length; i++){
      var item = _items[i];
      ret.add(IngridientDraftListItem("${i + 1} - $item", key: ValueKey(item), edit: _editItem, delete: _deleteItem, index: i));
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