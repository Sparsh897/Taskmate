import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_mate/controllers/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            const logoSize = 150.0;
            const iconSize = 100.0;
            const titleFontSize = 30.0;
            const descFontSize = 16.0;
            const buttonFontSize = 16.0;
            const buttonIconSize = 24.0;
            const termsFontSize = 12.0;
            final paddingH = constraints.maxWidth * 0.08;
            final paddingV = constraints.maxHeight * 0.03;

            return Center(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: paddingH,
                  vertical: paddingV,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: logoSize,
                      width: logoSize,
                      decoration: BoxDecoration(
                        color: Get.theme.primaryColor.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.check_circle_outline,
                        size: iconSize,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.05),
                    Text(
                      "Welcome to TaskMate!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: titleFontSize,
                        fontWeight: FontWeight.w800,
                        color: Get.theme.primaryColor,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.015),
                    Text(
                      "Organize your tasks effortlessly.\nSign in to get started!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: descFontSize,
                        color: Colors.grey[600],
                        height: 1.4,
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.06),
                    InkWell(
                      onTap: authController.signInWithGoogle,
                      borderRadius: BorderRadius.circular(12),
                      child: Ink(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.grey.shade300, width: 1),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 14, horizontal: 20),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                width: buttonIconSize,
                                height: buttonIconSize,
                              ),
                              const SizedBox(width: 14),
                             const Text(
                                "Sign in with Google",
                                style: TextStyle(
                                  fontSize: buttonFontSize,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.025),
                    Text(
                      "By continuing, you agree to our Terms of Service",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: termsFontSize,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
