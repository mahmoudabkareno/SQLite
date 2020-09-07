import 'package:flutter/material.dart';
import 'package:sqflite/sql.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqllite_app/Utils/DataBase_Helper.dart';

import 'Model/User.dart';

List AllUsers;
var db = new DatabaseHelper();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//  int insertUser = await db.saveUser(new User('Mohamed', '123', 'Dalas', 30));
//  print("saved user : $insertUser");

  int countOfUsers = await db.getCount();
//  print('Total: countOfUsers');

//  User Mahmoud = await db.getUser(2);
//  print('username : ${Mahmoud.username}');
//  print('Age : ${Mahmoud.age}');

//int deleteUser = await db.deleteUser(2);
//  print('deleteUser : ${deleteUser}');

//  User objUpdate =  User.fromMap({
//    "username" :  'Muhammed' ,
//    "password" :  '123456' ,
//    "city" :  'Erbil' ,
//    "age" :  55,
//    "id" :  2
//  });

//  await db.updateUser(objUpdate);

  AllUsers = await db.getAllUsers();
//  for(int i =0 ; i < myUsers.length;i++){
//    User user = User.map(myUsers[i]);
//    print('ID: ${user.id} - username: ${user.username} - city: ${user.age}');
//
//  }

  runApp(new MaterialApp(
    home: new Home(),
    title: 'SqLite',
  ));
}

class Home extends StatelessWidget {
  TextEditingController nameController = new TextEditingController();
  TextEditingController passController = new TextEditingController();
  TextEditingController cityController = new TextEditingController();
  TextEditingController ageController = new TextEditingController();
  addItemToList() async {
    var a = int.parse(ageController.text.toString());
    await db.saveUser(new User('${nameController.text}',
        '${passController.text}', '${cityController.text}', a));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text('SQLITE'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.greenAccent,
      body: new Column(
        children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact Name',
                ),
              ),
              new Padding(padding: EdgeInsets.all(12.0)),
              TextField(
                controller: passController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact Password',
                ),
              ),
              new Padding(padding: EdgeInsets.all(12.0)),
              TextField(
                controller: cityController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact City',
                ),
              ),
              new Padding(padding: EdgeInsets.all(12.0)),
              TextField(
                controller: ageController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Contact age',
                ),
              ),
          new RaisedButton(
            child: Text('Add'),
            onPressed: () {
              addItemToList();
            },
          ),
          Expanded(
              child: new ListView.builder(
            itemCount: AllUsers.length,
            itemBuilder: (context, int i) {
              return new Card(
                color: Colors.cyan,
                child: new ListTile(
                  title: new Text("${User.fromMap(AllUsers[i]).username}"),
                  subtitle: new Row(
                    children: <Widget>[
                      new Column(
                        children: <Widget>[
                          new Text("City :"),
                          new Text("Age  :"),
                        ],
                      ),
                      new Column(
                        children: <Widget>[
                          new Text("${User.fromMap(AllUsers[i]).city}"),
                          new Text("${User.fromMap(AllUsers[i]).age}"),
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          ),),
        ],
      ),
    );
  }
}
