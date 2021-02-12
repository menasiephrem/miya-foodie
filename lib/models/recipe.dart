import 'dart:core';

class Recipe {
  String id;
  String name;
  String description;
  String serving;
  String prepareTime;
  String cookingTime;
  String note;
  List<dynamic> ingredients;
  List<dynamic> directions;
  DateTime createdAt;
  String createdBy;
  String createdByName;
  String img;
  String type;
  int rating;
  int voteCount;


  Recipe.empty();

  Recipe.init(String createdBy, String type){
    this.createdAt = DateTime.now();
    this.createdBy = createdBy;
    this.type = type;
    this.id = "${this.createdAt.microsecondsSinceEpoch}";
    rating = 0;
    voteCount = 0;
  }


  Recipe.fromData(Map<String, dynamic> data){
      this.id = data['id'];
      this.type = data['type'];
      this.rating = data['rating'];
      this.voteCount = data['voteCount'];
      this.img = data['img'];
      this.name = data['name'];
      this.description = data['description'];
      this.serving = data['serving'];
      this.prepareTime = data['prepareTime'];
      this.createdAt = data['createdAt'].toDate();
      this.cookingTime = data['cookingTime'];
      this.note = data['note'];
      this.ingredients = data['ingredients'];
      this.directions = data['directions'];
      this.createdBy = data['createdBy'];
      this.createdByName = data['createdByName'];
  }

  Map<String, dynamic> toJson() => {
      'id': id,
      'img': img,
      'rating': rating,
      'voteCount': voteCount,
      'name':name,
      'type':type,
      'description':description,
      'serving':serving,
      'prepareTime':prepareTime,
      'createdAt':createdAt,
      'cookingTime':cookingTime,
      'note':note,
      'ingredients':ingredients,
      'directions':directions,
      'createdBy':createdBy,
      'createdByName':createdByName
  };

  bool isEmpty(){
    return ( name == null && name == "") || ( description == null && description == "") || ( serving == null && serving == "") ||
            ( prepareTime == null && prepareTime == "") || ( cookingTime == null && cookingTime == "");
  }
}