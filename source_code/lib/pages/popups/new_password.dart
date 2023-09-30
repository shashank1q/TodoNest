import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/popup.dart';
import 'package:todo_app/widgets/textfield.dart';

class NewPasswordPopUp extends StatefulWidget {
  final TextEditingController passwordController;
  final bool Function() onSaveButtonPressed;
  final BuildContext context;
  const NewPasswordPopUp({super.key, required this.context, required this.onSaveButtonPressed, required this.passwordController});

  @override
  State<NewPasswordPopUp> createState() => _NewPasswordPopUpState();
}

class _NewPasswordPopUpState extends State<NewPasswordPopUp> {
  TextEditingController confirmPasswordController = TextEditingController();
  String errorText = '';
  bool showError = false;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.transparent,
      contentPadding: const EdgeInsets.all(0),
      content: Container(
        height: 458,
        width: 700,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          color: MyColors.green,
          border: Border.all(width: 2, color: MyColors.pink),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: MyConstants.gapBetween),
                myTextField('New Password', widget.passwordController, Icons.password_rounded, 600, isPassword: true),
                SizedBox(height: MyConstants.gapBetweenTextfields),
                myTextField('Re-Enter Password', confirmPasswordController, Icons.password_rounded, 600,
                    errorText: errorText, error: showError, isPassword: true),
                SizedBox(height: MyConstants.gapBetweenTextfields),
                myButton(() {
                  setState(() {
                    showError = true;
                    if (widget.passwordController.text == confirmPasswordController.text) {
                      bool ok = widget.onSaveButtonPressed();
                      if (ok) {
                        showError = false;
                        Navigator.of(widget.context).pop();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return MyPopUp(
                              message: 'Password changed Successfully.',
                              context: context,
                              onConfirm: () {
                                Navigator.of(context).popAndPushNamed(MyConstants.loginRoute);
                              },
                            );
                          },
                        );
                      } else {
                        errorText = 'Invalid Password!';
                      }
                    } else {
                      errorText = "Re-Entered password does not match";
                    }
                  });
                }, 'Save'),
                SizedBox(height: MyConstants.gapBetween)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
