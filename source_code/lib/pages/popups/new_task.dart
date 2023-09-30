import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/widgets/button.dart';
import 'package:todo_app/widgets/textfield.dart';

AlertDialog newTaskPopup(
    BuildContext context, VoidCallback onConfirm, TextEditingController titlecontroller, TextEditingController descController) {
  return AlertDialog(
      contentPadding: const EdgeInsets.all(0),
      backgroundColor: Colors.transparent,
      content: FittedBox(
        child: Container(
          height: 500,
          width: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: MyColors.green,
            border: Border.all(color: MyColors.pink, width: 2),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(titlecontroller.text == '' ? 'CREATE TASK' : 'EDIT TASK', style: MyTextStyles.medium),
              ),
              const SizedBox(height: 50),
              myTextField('Task Title', titlecontroller, null, 600),
              TextField(
                maxLines: 5,
                controller: descController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
                  labelText: 'Task Description',
                  labelStyle: MyTextStyles.inputLabel,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: MyColors.pink),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(width: 2, color: MyColors.lightGrey),
                  ),
                ),
                style: MyTextStyles.medium,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  myButton(() {
                    onConfirm();
                    Navigator.of(context).pop();
                    titlecontroller.text = '';
                    descController.text = "";
                  }, 'OK'),
                  const SizedBox(width: 10),
                  myButton(() {
                    titlecontroller.text = '';
                    descController.text = "";
                    Navigator.of(context).pop();
                  }, 'Cancel', transparent: true)
                ],
              ),
            ],
          ),
        ),
      ));
}
