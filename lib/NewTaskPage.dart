import "package:flutter/material.dart";
import "package:todo_app/todo_model.dart";

class NewTaskPage extends StatefulWidget {
  final Function(TodoModel)
      addTodo; //Function bring addTodo func from HomePage so that we can call the function on OnPressed
  const NewTaskPage({Key? key, required this.addTodo}) : super(key: key);

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
    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
          backgroundColor: colorScheme.secondaryContainer,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios_rounded),
          ),
          title: Text(
            "New Task",
            style: TextStyle(color: colorScheme.onSecondaryContainer),
          )),
      body: Padding(
        padding:
            const EdgeInsets.only(bottom: 20, top: 20, right: 20, left: 20),
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
                    dueDateController.text = date.toString().substring(0, 10);
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
                DropdownMenuItem(value: "Personal", child: Text("Personal")),
                DropdownMenuItem(value: "Wishlist", child: Text("Wishlist")),
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
                taskName: taskController.text,
                dueDate: dueDateController.text,
                type: dropDownValue,
                status: false),
          );
          Navigator.pop(context);
        },
        child: Icon(Icons.add, color: colorScheme.onTertiaryContainer),
      ),
    );
  }
}