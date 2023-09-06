import 'package:flutter/material.dart';
import 'package:todo_app/models/todo_model.dart';

class TodoCardWidget extends StatelessWidget {
  final TodoModel todoModel;
  final Function(String, bool) update;
  final Function(String) delete;

  const TodoCardWidget({
    Key? key,
    required this.todoModel,
    required this.update,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.secondaryContainer,
      child: ListTile(
        leading: Checkbox(
          onChanged: (value) {
            update(todoModel.id, value!);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: value == true
                    ? const Text("Great! Task completed!")
                    : const Text("Task unchecked")));
          },
          value: todoModel.status,
        ),
        title: Text(
          todoModel.taskName,
          style: const TextStyle(fontSize: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              todoModel.dueDate,
            ),
            Text(
              todoModel.description,
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ],
        ),
        trailing: SizedBox(
          width: 150,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                todoModel.type,
                style: TextStyle(
                    color: todoTypeColor(
                      todoModel.type,
                    ),
                    fontSize: 20),
              ),
              IconButton(
                onPressed: () {
                  delete(todoModel.id);
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Task deleted!")));
                },
                icon: const Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Color todoTypeColor(String value) {
  switch (value) {
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
