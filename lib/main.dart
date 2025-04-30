import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'controllers/auth_controller.dart';
import 'views/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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

class TaskMateApp extends StatelessWidget {
  final themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Task Mate',
          debugShowCheckedModeBanner: false,
          themeMode: themeController.theme,
          theme: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.teal,
            ),
          ),
          darkTheme: ThemeData.dark().copyWith(
            floatingActionButtonTheme: FloatingActionButtonThemeData(
              backgroundColor: Colors.tealAccent,
            ),
          ),
          home: SplashScreen(),
        ));
  }
}
