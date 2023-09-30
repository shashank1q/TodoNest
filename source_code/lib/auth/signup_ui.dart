import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_functions.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/user.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/logo.dart';
import 'package:todo_app/widgets/popup.dart';
import 'package:todo_app/widgets/textfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(gradient: MyConstants.myGradient),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const FittedBox(child: SizedBox(height: 80, width: 600)),
                // Logo
                FittedBox(
                  child: IntrinsicHeight(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      myLogo(size: 2),
                      const SizedBox(width: 30),
                      const VerticalDivider(
                        color: MyColors.teal,
                        thickness: 1,
                        width: 20,
                        indent: 15,
                        endIndent: 15,
                      ),
                      const SizedBox(width: 30),
                      const Text(
                        "Sign Up",
                        style: TextStyle(color: MyColors.white, fontSize: 96, fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
                const FittedBox(child: SizedBox(height: 90, width: 600)),
                FittedBox(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      myTextField('E-mail', emailController, Icons.email_rounded, MediaQuery.of(context).size.width),
                      SizedBox(height: MyConstants.gapBetweenTextfields),
                      myTextField(
                          'Create Password', passwordController, Icons.password_rounded, MediaQuery.of(context).size.width,
                          isPassword: true),
                      SizedBox(height: MyConstants.gapBetweenTextfields),
                      myTextField('Phone Number', phoneController, Icons.phone, MediaQuery.of(context).size.width),
                      SizedBox(height: MyConstants.gapBetweenTextfields),
                      const SizedBox(height: 20),
                      myButton(_onSignup, 'Sign Up'),
                      const SizedBox(height: 20)
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignup() async {
    MyUser.email = emailController.text;
    MyUser.phoneNumber = phoneController.text;
    MyUser.data = [
      {MyConstants.listname: 'Starred', MyConstants.data: []}
    ];

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    signup(emailController.text, passwordController.text).then(
      (res) {
        Navigator.of(context).pop();
        bool verified = false;
        if (MyConstants.signupSuccess == res) {
          verified = true;
        } else {
          MyUser.reset();
        }
        showDialog(
          context: context,
          builder: (context) {
            return MyPopUp(
              message: res,
              context: context,
              onConfirm: () {
                verified ? Navigator.of(context).pushNamed(MyConstants.loginRoute) : null;
              },
            );
          },
        );
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
