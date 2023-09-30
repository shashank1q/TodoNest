import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/textfield.dart';

AlertDialog newListPopup(VoidCallback onConfirm, BuildContext context, TextEditingController controller) {
  return AlertDialog(
    contentPadding: const EdgeInsets.all(0),
    backgroundColor: Colors.transparent,
    content: FittedBox(
      child: Container(
        width: 500,
        height: 320,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: MyColors.green,
          border: Border.all(color: MyColors.pink, width: 2),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 18),
        child: Column(
          children: [
            Text('Name Your List', style: MyTextStyles.medium),
            SizedBox(height: MyConstants.gapBetween),
            myTextField('List Name', controller, null, MediaQuery.of(context).size.width),
            SizedBox(height: MyConstants.gapBetween),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                myButton(() {
                  Navigator.of(context).pop();
                  onConfirm();
                  controller.text = '';
                }, 'OK'),
                const SizedBox(width: 10),
                myButton(() {
                  controller.text = '';
                  Navigator.of(context).pop();
                }, 'Cancel', transparent: true)
              ],
            ),
            SizedBox(height: MyConstants.gapBetween),
          ],
        ),
      ),
    ),
  );
}
