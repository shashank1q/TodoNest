import 'package:flutter/material.dart';
import 'package:todo_app/services/database_func.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/utils/user.dart';

// ignore: must_be_immutable
class MyTask extends StatefulWidget {
  bool value;
  String title;
  String desc;
  final int listpos;
  final int taskpos;
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  MyTask({
    super.key,
    required this.value,
    required this.title,
    required this.desc,
    required this.listpos,
    required this.taskpos,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  State<MyTask> createState() => _MyTaskState();
}

class _MyTaskState extends State<MyTask> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(width: 15),
        Checkbox(
          value: widget.value,
          checkColor: MyColors.white,
          fillColor: MaterialStateColor.resolveWith((states) {
            return MyColors.pink;
          }),
          onChanged: (value) => setState(() {
            widget.value = value ?? false;
            MyUser.taskCompleted(widget.listpos, widget.taskpos, widget.value);
            databaseUpdate(MyUser.email, 'data', MyUser.data);
          }),
        ),
        const SizedBox(width: 10),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              MyUser.data[widget.listpos][MyConstants.data][widget.taskpos][MyConstants.taskname],
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: titlefont(),
                  fontWeight: FontWeight.normal,
                  color: widget.value ? MyColors.whiteFaded : MyColors.white,
                  decoration: widget.value ? TextDecoration.lineThrough : null),
            ),
            const SizedBox(height: 5),
            Text(
              MyUser.data[widget.listpos][MyConstants.data][widget.taskpos][MyConstants.taskdesc],
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: MyTextStyles.small(forList: true, strikethrough: widget.value),
            ),
          ],
        )),
        const SizedBox(width: 10),
        IconButton(onPressed: widget.onEdit, icon: Icon(Icons.edit, color: MyColors.teal, size: iconSize())),
        const SizedBox(width: 10),
        IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete_rounded, color: MyColors.red, size: iconSize())),
        const SizedBox(width: 15),
      ],
    );
  }

  double titlefont() {
    double size = MediaQuery.of(context).size.width;
    if (size > 750) {
      return 25;
    } else if (size > 650) {
      return 23;
    } else if (size > 550) {
      return 20;
    }
    return 18;
  }

  double iconSize() {
    double size = MediaQuery.of(context).size.width;
    if (size > 750) {
      return 40;
    } else if (size > 650) {
      return 35;
    } else if (size > 550) {
      return 30;
    }
    return 25;
  }
}
