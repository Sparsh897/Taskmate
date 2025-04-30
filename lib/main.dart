import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/views/login_screen.dart';
import 'package:task_mate/views/todo_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  Get.put(AuthController()); // Register AuthController globally
  runApp(TaskMateApp());
}

class ThemeController extends GetxController {
  var isDarkMode = false.obs;

  ThemeMode get theme => isDarkMode.value ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeThemeMode(theme);
  }
}

// ignore: use_key_in_widget_constructors
class TaskMateApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'TaskMate',
          debugShowCheckedModeBanner: false,
          themeMode: themeController.theme,
          theme: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.teal,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.tealAccent,
            ),
          ),
          home: authController.user.value == null
              ? LoginScreen()
              : TodoScreen(),
        ));
  }
}
