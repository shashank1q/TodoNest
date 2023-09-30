import 'package:flutter/material.dart';
import 'package:todo_app/utils/colors.dart';

Widget myLogo({double size = 1}) {
  if (size == 1) {
    size = 105;
  } else if (size == 2) {
    size = 96;
  } else if (size == 3) {
    size = 35;
  } else {
    size = 25;
  }
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        "TODO",
        style: TextStyle(color: MyColors.pink, fontSize: size, fontWeight: FontWeight.bold),
      ),
      const SizedBox(width: 5),
      Text(
        "NEST",
        style: TextStyle(color: MyColors.white, fontSize: size, fontWeight: FontWeight.bold),
      ),
    ],
  );
}
