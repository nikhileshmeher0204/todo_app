import 'package:flutter/material.dart';
import 'package:todo_app/todo_model.dart';
class NewTaskPage extends StatefulWidget {
  final Function(TodoModel) addTodo;
  const NewTaskPage({
    Key? key,
    required this.addTodo,
  }) : super(key: key);

  @override
  State<NewTaskPage> createState() => _NewTaskPageState();
}

class _NewTaskPageState extends State<NewTaskPage> {
  TextEditingController taskController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  String dropDownValue = "Work";
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    print("rebuild");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded)),
        title: const Text("New Task"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          right: 20,
          left: 20,
          top: 20,
          bottom: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "What is the task?",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextField(
              controller: taskController,
              decoration: InputDecoration(
                hintText: "Enter the task",
                border: const OutlineInputBorder(),
                fillColor: colorScheme.secondaryContainer,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Due date",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: dueDateController,
                    decoration: InputDecoration(
                      hintText: "Date not set",
                      border: const OutlineInputBorder(),
                      fillColor: colorScheme.secondaryContainer,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2100),
                    );
                    dueDateController.text =
                        date.toString().substring(0, 10);
                  },
                  icon: const Icon(Icons.calendar_month),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              "Add to list",
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            DropdownButton(
              isExpanded: true,
              value: dropDownValue,
              items: const [
                DropdownMenuItem(value: "Work", child: Text("Work")),
                DropdownMenuItem(
                    value: "Personal", child: Text("Personal")),
                DropdownMenuItem(
                    value: "Wishlist", child: Text("Wishlist")),
                DropdownMenuItem(value: "Shopping", child: Text("Shopping"))
              ],
              onChanged: (value) {
                dropDownValue = value!;
                setState(() {});
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          widget.addTodo(
            TodoModel(
              id: DateTime.now().toString(),
              dueDate: dueDateController.text,
              status: false,
              taskName: taskController.text,
              type: dropDownValue,
            ),
          );
          Navigator.pop(context);
        },
        child: const Icon(
          Icons.check,
        ),
      ),
    );
  }
}
