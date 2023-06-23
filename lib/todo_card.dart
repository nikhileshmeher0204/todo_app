import 'package:flutter/material.dart';
import 'package:todo_app/todo_model.dart';

class TodoCard extends StatelessWidget {
  final TodoModel todoModel;
  final Function(String, bool) update;
  const TodoCard({Key? key, required this.todoModel, required this.update}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      color: colorScheme.secondaryContainer,
      child: ListTile(
        leading: Checkbox(
          checkColor: colorScheme.tertiaryContainer,
          onChanged: (value) {
            update(todoModel.id, value!);
          },
          value: todoModel.status,
        ),
        title: Text(todoModel.taskName),
        subtitle: Text(
          todoModel.dueDate,
          style: TextStyle(color: colorScheme.onSecondaryContainer),
        ),
        trailing: Text(
          todoModel.type,
          style:
              TextStyle(fontSize: 20, color: todoTypeColor(todoModel.type)),
        ),
      ),
    );
  }
}

Color todoTypeColor(String value){
  switch(value){
    case "Shopping":
      return Colors.green;
    case "Work":
      return Colors.amber;
    case "Personal":
      return Colors.deepPurple;
    case "Wishlist":
      return Colors.indigoAccent;
    default:
      return Colors.black;
  }
}