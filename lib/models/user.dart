

class User{
   String name;
   String sex;
   String userName;
   String createdAt;
   String password;

    User(String name, String userName, String passowrd){
      this.name = name;
      this.createdAt = DateTime.now().toString();
      this.userName = userName;
      this.password = passowrd;
   }

   User.empty();

    User.fromData(Map<String, dynamic> data){
      this.name = data['name'];
      this.createdAt = data['createdAt'] is String? data['createdAt'] : data['createdAt'].toDate().toString();
      this.userName = data['userName'];
      this.sex = data['sex'];
      this.password = data['password'];
   }

  Map<String, dynamic> toJson() => {
    "name": name,
    "userName": userName,
    "sex": sex,
    "createdAt":createdAt,
    "password": password
  };

}