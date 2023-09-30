import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';

class MyConstants {
  static LinearGradient myGradient =
      const LinearGradient(colors: [MyColors.green, MyColors.black], begin: Alignment.topCenter, end: Alignment.bottomCenter);
  static String secretQuestionText = 'Select a seceret Question. ';
  static List<String> secretQuestions = [
    secretQuestionText,
    "What's your first school name?",
    "What's your nickname?",
    "What's your best friend's name?",
    "What's name of your pet?",
    "What's your lucky number",
  ];

  static double gapBetweenTextfields = 5;
  static double gapBetween = 32;
  static String signupRoute = '/SignUp';
  static String loginRoute = '/login';
  static String resetRoute = '/ResetPassword';
  static String dashborardRoute = '/Dashboard';

  static String listname = 'listName';
  static String taskname = 'taskName';
  static String taskdesc = 'taskDescription';
  static String taskcompleted = 'taskCompleted';
  static String data = 'data';
  static String loginSuccess = "Login Success";
  static String signupSuccess = "Account created Successfully";
}
