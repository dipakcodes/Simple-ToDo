import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {

  List todolist = [];

  //reference our box
  final _myBox = Hive.box('mybox');

  //run this method if this is the first time ever opening this app
  void createInitialData() {
    todolist = [
      ["Workout for 30 min", false],
      ["wake up at 7am", false],
    ];
  }

  //load the data from the database
  void loadData() {
    todolist = _myBox.get("TODOLIST");

  }


  //update the database
  void updateDataBase() {
    _myBox.put("TODOLIST", todolist);

  }
}