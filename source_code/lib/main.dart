import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/auth/reset.dart';
import 'package:todo_app/auth/signup_ui.dart';
import 'package:todo_app/pages/dashboard.dart';
import 'package:todo_app/auth/login_ui.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAwkmdxzrAyXtJBSRTLMfbKPTc26Es-4Gs",
          projectId: "flutterweb1q",
          messagingSenderId: "538147697031",
          appId: "1:538147697031:web:132fb9676937e6f639a322"));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: MyColors.pink,
          fontFamily: 'Karla',
          scrollbarTheme: const ScrollbarThemeData(
            thumbVisibility: MaterialStatePropertyAll(true),
            thumbColor: MaterialStatePropertyAll(MyColors.whiteFaded),
          )),
      initialRoute: MyConstants.loginRoute,
      routes: {
        MyConstants.loginRoute: (context) => const LoginPage(),
        MyConstants.signupRoute: (context) => const SignupPage(),
        MyConstants.dashborardRoute: (context) => const DashBoard(),
        MyConstants.resetRoute: (context) => const ResetPage(),
      },
    );
  }
}
