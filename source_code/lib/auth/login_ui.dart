import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_functions.dart';
import 'package:todo_app/services/database_func.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/utils/user.dart';
import 'package:todo_app/widgets/Logo.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/popup.dart';
import 'package:todo_app/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String dropdowntext = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: MyConstants.myGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Center(
            child: FittedBox(
              child: Column(
                children: [
                  const SizedBox(height: 90),
                  Padding(padding: const EdgeInsets.all(20), child: myLogo()),
                  const SizedBox(height: 70),
                  myTextField('Enter E-mail ID', emailController, Icons.email_rounded, MediaQuery.of(context).size.width),
                  SizedBox(height: MyConstants.gapBetweenTextfields),
                  myTextField('Enter Password', passwordController, Icons.password_rounded, MediaQuery.of(context).size.width,
                      isPassword: true),
                  const SizedBox(height: 35),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      myButton(_onLogin, 'Login'),
                      const SizedBox(width: 10),
                      myButton(() {
                        Navigator.of(context).pushNamed(MyConstants.signupRoute);
                      }, 'Sign Up', transparent: true),
                    ],
                  ),
                  const SizedBox(height: 67),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Trouble Signing in? ', style: MyTextStyles.medium),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(MyConstants.resetRoute);
                        },
                        child: Text('Reset Password', style: MyTextStyles.link),
                      )
                    ],
                  ),
                  const SizedBox(height: 25)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onLogin() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    signIn(emailController.text, passwordController.text).then(
      (res) {
        Navigator.of(context).pop();
        String msg = res;
        if (MyConstants.loginSuccess == msg) {
          MyUser.email = emailController.text;
          getData(emailController.text).then((value) {
            msg = value;
            showDialog(
              context: context,
              builder: (context) {
                return MyPopUp(
                  message: msg == 'Success' ? res : msg,
                  context: context,
                  onConfirm: () {
                    msg == 'Success' ? Navigator.of(context).pushNamed(MyConstants.dashborardRoute) : null;
                  },
                );
              },
            );
          });
        } else {
          showDialog(
            context: context,
            builder: (context) {
              return MyPopUp(message: res, context: context);
            },
          );
        }
      },
    ).onError((error, stackTrace) {
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (context) {
          return MyPopUp(message: error.toString(), context: context);
        },
      );
    });
  }
}
