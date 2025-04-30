import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/models/todo_modal.dart';
import '../controllers/todo_controller.dart';

class TodoTile extends StatelessWidget {
  final TodoModel todo;
  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    final TodoController controller = Get.find();
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.03,
        vertical: 6,
      ),
      child: ListTile(
        leading: Checkbox(
          value: todo.isDone,
          onChanged: (val) {
            controller.updateTodoStatus(todo.id, val!);
          },
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: IconButton(
          icon:const Icon(Icons.delete, color: Colors.redAccent),
          onPressed: () => controller.deleteTodo(todo.id),
        ),
      ),
    );
  }
}
