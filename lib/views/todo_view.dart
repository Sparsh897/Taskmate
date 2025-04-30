import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/todo_controller.dart';
import 'package:task_mate/widgets/todo_tile.dart';
import '../controllers/auth_controller.dart';
import '../main.dart';

// ignore: use_key_in_widget_constructors
class TodoScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();
  final todoController = Get.put(TodoController());
  final themeController = Get.find<ThemeController>();

  void _showAddTaskDialog() {
    final TextEditingController taskController = TextEditingController();

    showDialog(
      context: Get.context!,
      barrierDismissible: false,
      builder: (context) {
        final isDark = Get.isDarkMode;
        return AlertDialog(
          backgroundColor: Get.theme.cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: Text(
            "Add New Task",
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            controller: taskController,
            autofocus: true,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black,
            ),
            decoration: InputDecoration(
              hintText: "What’s your next task?",
              hintStyle: TextStyle(
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              filled: true,
              fillColor: isDark ? Colors.white12 : Colors.black12,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          actions: [
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.redAccent,
              ),
              onPressed: () {
                FocusScope.of(context).unfocus();
                Navigator.of(context).pop();
              },
              child:const  Text("Cancel"),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Get.theme.primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                final text = taskController.text.trim();
                if (text.isNotEmpty) {
                  todoController.addTodo(text);
                  FocusScope.of(context).unfocus();
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar("Error", "Please enter a task");
                }
              },
              child:const Text("Add Task"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = authController.user.value!;
    todoController.init(user.uid);

    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth * 0.04;
        final verticalPadding = constraints.maxHeight * 0.02;

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text('Welcome, ${user.displayName}'),
            actions: [
              Obx(() {
                return IconButton(
                  icon: Icon(
                    themeController.isDarkMode.value
                        ? Icons.brightness_7
                        : Icons.brightness_2,
                  ),
                  onPressed: themeController.toggleTheme,
                );
              }),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPadding / 2),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL ?? ""),
                ),
              ),
              IconButton(
                icon:const  Icon(Icons.logout),
                onPressed: () => authController.signOut(),
              ),
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: horizontalPadding,
              vertical: verticalPadding,
            ),
            child: Obx(() => ListView.builder(
                  itemCount: todoController.todos.length,
                  itemBuilder: (_, index) {
                    final todo = todoController.todos[index];
                    return TodoTile(todo: todo);
                  },
                )),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showAddTaskDialog,
            child: const Icon(
              Icons.add,
              color: Colors.black,
            ),
          ),
        );
      },
    );
  }
}
