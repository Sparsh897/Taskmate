import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/auth_controller.dart';
import 'package:task_mate/views/login_screen.dart';
import 'package:task_mate/views/todo_view.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    _scale = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _controller.forward();
    Future.delayed(Duration(seconds: 2), () {
      final user = Get.find<AuthController>().user.value;
      Get.offAll(() => user == null ? LoginScreen() : TodoScreen());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.primaryColor,
      body: LayoutBuilder(
        builder: (ctx, c) {
          final size = c.maxWidth * 0.4;
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ScaleTransition(
                  scale: _scale,
                  child: Container(
                    height: size,
                    width: size,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset('assets/logo.png'),
                  ),
                ),
                SizedBox(height: c.maxHeight * 0.04),
                Text(
                  'TaskMate',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: c.maxWidth * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: c.maxHeight * 0.02),
                SizedBox(
                  height: 4,
                  width: c.maxWidth * 0.3,
                  child: LinearProgressIndicator(
                    color: Colors.white70,
                    backgroundColor: Colors.white24,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
