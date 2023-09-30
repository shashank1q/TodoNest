import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/styles.dart';

SizedBox myButton(VoidCallback onPress, String text, {bool transparent = false, bool isDisabled = false}) {
  return SizedBox(
    height: 60,
    width: 200,
    child: ElevatedButton(
      onPressed: isDisabled ? null : onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: transparent ? Colors.transparent : MyColors.pink,
        shadowColor: transparent ? Colors.transparent : MyColors.black,
        disabledBackgroundColor: MyColors.darkGrey,
        disabledForegroundColor: MyColors.white,
        foregroundColor: transparent ? MyColors.pink : MyColors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(text, style: MyTextStyles.large),
    ),
  );
}
