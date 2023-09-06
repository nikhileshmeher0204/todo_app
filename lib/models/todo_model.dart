class TodoModel {
  final String id;
  final String taskName;
  final String dueDate;
  final String type;
  final String description;
   bool status;
  TodoModel({
    required this.description,
    required this.id,
    required this.dueDate,
    required this.status,
    required this.taskName,
    required this.type,
  });
}
