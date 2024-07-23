import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_todo/data/database.dart';
import 'package:simple_todo/utils/todo_list.dart';
class HomePage extends StatefulWidget {
 const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _myBox = Hive.box('mybox');
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
  //if this is the first time ever opening the app then create the default data
  if (_myBox.get("TODOLIST") == null ) {
    db.createInitialData();

  }else {
    //there already exists the data
    db.loadData();
  }

    super.initState();
  }


  final _controller = TextEditingController();
  

  void checkBoxChanged(int index){
    setState(() {
      db.todolist[index][1] = !db.todolist[index][1];
    });
    db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.todolist.add([_controller.text, false]);
      _controller.clear();
    });
    db.updateDataBase();
  }

  void deleteTask(int index) {
  setState((){
    db.todolist.removeAt(index);
  });
  db.updateDataBase();
  }


  @override
  Widget build (BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade300,
    appBar: AppBar(
      title:const Center(
        child: Text(
          'Todo',
        ),
      ),
      backgroundColor:Colors.deepPurple,
      foregroundColor: Colors.white,
    ),
    body: ListView.builder(
      itemCount: db.todolist.length,
      itemBuilder: (BuildContext context, index) {
        return TodoList(
          taskName: db.todolist[index][0],
          taskCompleted: db.todolist[index][1],
          onChanged: (value) => checkBoxChanged(index),
          deleteFunction: (contex) => deleteTask(index),


        );
     }),

     floatingActionButton: Row(
       children: [
        Expanded(
          child: Padding(
            padding:const  EdgeInsets.only(
                top: 20,
                left: 35,
                right: 15,
                bottom: 18,
              ),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add a new-todo item',
                filled: true,
                fillColor: Colors.deepPurple.shade200,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.deepPurple,
                    
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:const  BorderSide(
                    color: Colors.deepPurple,
                    
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
          ),
        ),
        
         FloatingActionButton(
          onPressed: saveNewTask,
          child:const Icon(Icons.add),
          
          ),
       ],
     ),
     
    );
  }
}