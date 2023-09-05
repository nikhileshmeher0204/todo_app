import 'package:flutter/material.dart';
import 'package:todo_app/todo_model.dart';

class NewTaskPage extends StatefulWidget {
  static String routeName = "/newTaskPage";
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
  TextEditingController taskDescriptionController = TextEditingController();
  TextEditingController dueDateController = TextEditingController();
  String dropDownValue = "Work";
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: const Text("New Task"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "What is the task?",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              TextField(
                controller: taskController,
                decoration: const InputDecoration(
                  labelText: "Task",
                  hintText: "Enter the task",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Task description",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              TextField(
                controller: taskDescriptionController,
                maxLength: 20,
                decoration: const InputDecoration(
                  labelText: "Description (optional)",
                  hintText: "Enter description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Due date",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Row(
                children: [
                  SizedBox(
                    width: 300,
                    child: TextField(
                      controller: dueDateController,
                      decoration: const InputDecoration(
                        labelText: "Date",
                        hintText: "Date not set",
                        border: OutlineInputBorder(),
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
              const Text(
                "Add to list",
                style: TextStyle(
                  fontSize: 25,
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (dueDateController.text.isEmpty || taskController.text.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please enter the required task details")));
          } else {
            widget.addTodo(
              TodoModel(
                id: DateTime.now().toString(),
                dueDate: dueDateController.text,
                status: false,
                taskName: taskController.text,
                type: dropDownValue,
                description: taskDescriptionController.text,
              ),
            );
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Task added successfully!")));
            Navigator.pop(context);
          }
        },
        backgroundColor: colorScheme.tertiary,
        child: Icon(
          Icons.check,
          color: colorScheme.onTertiary,
        ),
      ),
    );
  }
}
