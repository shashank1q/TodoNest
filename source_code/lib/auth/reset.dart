import 'package:flutter/material.dart';
import 'package:todo_app/services/auth_functions.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/logo.dart';
import 'package:todo_app/widgets/textfield.dart';

class ResetPage extends StatefulWidget {
  const ResetPage({super.key});

  @override
  State<ResetPage> createState() => _ResetPageState();
}

class _ResetPageState extends State<ResetPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  bool disableSendButton = false;
  String message = ' ';

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
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const FittedBox(child: SizedBox(height: 90, width: 600)),
              //Logo
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
                      "RESET",
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
                    Text(message, style: MyTextStyles.medium),
                    SizedBox(height: message == ' ' ? 1 : 90, width: 600),
                    myTextField('E-mail', emailController, Icons.email_rounded, MediaQuery.of(context).size.width),
                    SizedBox(height: MyConstants.gapBetweenTextfields),
                    myButton(_onSend, 'Send', isDisabled: disableSendButton),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _onSend() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    resetPassword(emailController.text).then((value) {
      //Navigator.of(context).pop();
      if (value == "Success") {
        setState(() {
          Navigator.of(context).pop();
          message = "Password Reset link has been sent to your email";
          disableSendButton = true;
        });
      } else {
        setState(() {
          message = value;
          Navigator.of(context).pop();
        });
      }
    });
  }
}
