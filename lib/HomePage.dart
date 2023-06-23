import 'package:flutter/material.dart';
import 'package:todo_app/todo_card.dart';
import 'package:todo_app/todo_model.dart';
import 'NewTaskPage.dart';
import 'data.dart';

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
      tempListOfTodo.add(todoModel);
    }
    setState(() {});
  }

  updateStatus(String id, bool status) async {
    int index = listOfTodo.indexWhere((element) => element.id == id);
    listOfTodo[index].status = status;
    setState(() {});

    await Future.delayed(const Duration(milliseconds: 500));

    if (category == "All List") {
      tempListOfTodo = listOfTodo;
    } else if (category == "Pending") {
      tempListOfTodo =
          listOfTodo.where((element) => element.status == false).toList();
    } else if (category == "Finished") {
      tempListOfTodo =
          listOfTodo.where((element) => element.status == true).toList();
    } else {
      tempListOfTodo =
          listOfTodo.where((element) => element.type == category).toList();
    }
    setState(() {});
  }

  List<TodoModel> listOfTodo = [];
  List<TodoModel> tempListOfTodo = [];
  String category = "Pending";
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: colorScheme.surfaceVariant,
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
        child: Icon(Icons.add, color: colorScheme.onTertiaryContainer),
      ),
      backgroundColor: colorScheme.onInverseSurface,
      appBar: AppBar(
        title: Text(
          "TODO: $category",
          style: TextStyle(color: colorScheme.onPrimary),
        ),
        backgroundColor: colorScheme.primary,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              category = value;
              if (category == "All List") {
                tempListOfTodo = listOfTodo;
              } else if (category == "Pending") {
                tempListOfTodo = listOfTodo
                    .where((element) => element.status == false)
                    .toList();
              } else if (category == "Finished") {
                tempListOfTodo = listOfTodo
                    .where((element) => element.status == true)
                    .toList();
              } else {
                tempListOfTodo = listOfTodo
                    .where((element) => element.type == value)
                    .toList();
              }
              setState(() {});
            },
            color: colorScheme.onPrimary,
            itemBuilder: (context) => popUpMenuItemTtileList
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
      body: ListView(
        children: tempListOfTodo
            .map(
              (e) => TodoCard(
                todoModel: e,
                update: updateStatus,
              ),
            )
            .toList(),
      ),
    );
  }
}
