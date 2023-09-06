import 'package:flutter/material.dart';
import 'package:todo_app/data.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';
import 'package:todo_app/models/todo_model.dart';
import 'package:todo_app/screens/new_task_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void addTodo(TodoModel todoModel) {
    listOfTodo.add(todoModel);
    if (category == "All List" ||
        category == "Pending" ||
        category == todoModel.type) {
      _tempListOfTodo.add(todoModel);
    }
    setState(() {});
  }

  void deleteTask(String id) {
    listOfTodo.removeWhere((element) => element.id == id);
    _tempListOfTodo.removeWhere((element) => element.id == id);
    setState(() {});
  }

  String category = "All List";
  updateStatus(String id, bool status) async {
    int index = listOfTodo.indexWhere((element) => element.id == id);
    listOfTodo[index].status = status;
    setState(() {});
    await Future.delayed(const Duration(milliseconds: 500));
    if (category == "All List") {
      _tempListOfTodo = listOfTodo.toList();
    } else if (category == "Pending") {
      _tempListOfTodo =
          listOfTodo.where((element) => element.status == false).toList();
    } else if (category == "Finished") {
      _tempListOfTodo =
          listOfTodo.where((element) => element.status == true).toList();
    } else {
      _tempListOfTodo =
          listOfTodo.where((element) => element.type == category).toList();
    }
    setState(() {});
  }

  List<TodoModel> listOfTodo = [];
  List<TodoModel> _tempListOfTodo = [];
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (child) => NewTaskPage(
                addTodo: addTodo,
              ),
            ),
          );
        },
        backgroundColor: colorScheme.tertiary,
        child: Icon(Icons.add, color: colorScheme.onTertiary,),
      ),
      appBar: AppBar(
        title: Text("TODO: $category"),
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              category = value;
              if (category == "All List") {
                _tempListOfTodo = listOfTodo.toList();
              } else if (category == "Pending") {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.status == false)
                    .toList();
              } else if (category == "Finished") {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.status == true)
                    .toList();
              } else {
                _tempListOfTodo = listOfTodo
                    .where((element) => element.type == value)
                    .toList();
              }
              setState(() {});
            },
            itemBuilder: (context) => popUpMenuItemTitleList
                .map(
                  (e) => PopupMenuItem(
                    value: e,
                    child: Text(
                      e,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
      body:Stack(
        children: [
           Column(
             crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(_tempListOfTodo.where((element) => element.status == false).isNotEmpty?
                "You have ${_tempListOfTodo.where((element) => element.status == false).length} tasks left out of ${listOfTodo.length}":" Add new tasks to show them here!",
                style: const TextStyle(
                  fontSize: 20,
                  fontStyle: FontStyle.italic
                ),
              ),
              Expanded(
                child: ListView(
                  children: _tempListOfTodo
                      .map(
                        (e) => TodoCardWidget(
                      todoModel: e,
                      update: updateStatus,
                      delete: deleteTask,
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),
        ],

      )
    );
  }
}
