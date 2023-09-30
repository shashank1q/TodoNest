import 'package:todo_app/utils/constants.dart';

class MyUser {
  static String email = '';
  static String phoneNumber = '';
  static List<dynamic> data = [{}];

  static void createList(String listName) {
    data.add({MyConstants.listname: listName, MyConstants.data: []});
  }

  static void createTask(int listpos, String title, String desc) {
    data[listpos][MyConstants.data].add({
      MyConstants.taskname: title,
      MyConstants.taskdesc: desc,
      MyConstants.taskcompleted: 'n',
    });
  }

  static void taskCompleted(int listpos, int taskpos, bool status) {
    data[listpos][MyConstants.data][taskpos][MyConstants.taskcompleted] = status ? 'y' : 'n';
  }

  static void taskUpdate(int listpos, int taskpos, String title, String desc) {
    data[listpos][MyConstants.data][taskpos][MyConstants.taskname] = title;
    data[listpos][MyConstants.data][taskpos][MyConstants.taskdesc] = desc;
  }

  static void deleteList(int listpos) {
    data.removeAt(listpos);
  }

  static void deleteTask(int listpos, int taskpos) {
    data[listpos][MyConstants.data].removeAt(taskpos);
  }

  static void reset() {
    email = '';
    phoneNumber = '';
    data = [{}];
  }
}
