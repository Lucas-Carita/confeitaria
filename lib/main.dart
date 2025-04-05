import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/auth_controller.dart';
import 'package:flutter_application_1/controller/cart_controller.dart';
import 'package:flutter_application_1/controller/favorite_controller.dart';
import 'package:flutter_application_1/view/about_view.dart';
import 'package:flutter_application_1/view/cart_view.dart';
import 'package:flutter_application_1/view/favorite_view.dart';
import 'package:flutter_application_1/view/forgot_password_view.dart';
import 'package:flutter_application_1/view/home_view.dart';
import 'package:flutter_application_1/view/login_view.dart';
import 'package:flutter_application_1/view/profile_view.dart';
import 'package:flutter_application_1/view/register_view.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void main() {
  getIt.registerSingleton<AuthController>(AuthController());
  getIt.registerSingleton<CartController>(CartController());
  getIt.registerSingleton<FavoriteController>(FavoriteController());

  runApp(DevicePreview(enabled: true, builder: (context) => const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Confeitaria',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/forgot_password': (context) => const ForgotPasswordView(),
        '/home': (context) => const HomeView(),
        '/favorite': (context) => const FavoriteView(),
        '/cart': (context) => const CartView(),
        '/profile': (context) => const ProfileView(),
        '/about': (context) => const AboutView(),
      },
    );
  }
}
