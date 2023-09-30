import 'package:flutter/material.dart';
import 'package:todo_app/pages/popups/new_list.dart';
import 'package:todo_app/pages/popups/new_task.dart';
import 'package:todo_app/services/auth_functions.dart';
import 'package:todo_app/services/database_func.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/styles.dart';
import 'package:todo_app/utils/user.dart';
import 'package:todo_app/widgets/logo.dart';
import 'package:todo_app/widgets/popup.dart';
import 'package:todo_app/widgets/task.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({super.key});

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> with TickerProviderStateMixin {
  TextEditingController newListController = TextEditingController();
  TextEditingController newTaskTitleController = TextEditingController();
  TextEditingController newTaskDescController = TextEditingController();
  int tabIndex = 0;

  // @override
  // void initState() {
  //   MyUser.data = [
  //     {MyConstants.listname: 'Starred', MyConstants.data: []}
  //   ];
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: MyUser.data.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: MyColors.green,
          leading: Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.width < 600 ? 20 : 30),
            child: myLogo(size: MediaQuery.of(context).size.width < 600 ? 4 : 3),
          ),
          leadingWidth: 300,
          toolbarHeight: 80,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: MediaQuery.of(context).size.width < 600 ? 20 : 30),
              child: PopupMenuButton(
                icon: const Icon(Icons.settings, color: MyColors.pink, size: 30),
                color: MyColors.lightGrey,
                position: PopupMenuPosition.under,
                tooltip: '',
                itemBuilder: (context) => [
                  PopupMenuItem(
                      onTap: () {
                        Navigator.of(context).pushNamed(MyConstants.resetRoute);
                      },
                      child: Text(
                        'Change Password',
                        style: MyTextStyles.small(forList: false),
                      )),
                  PopupMenuItem(
                      onTap: () {
                        if (MyUser.data.length <= 1) {
                          showDialog(
                            context: context,
                            builder: (context) => MyPopUp(message: 'You must have 1 list', context: context),
                          );
                        } else {
                          setState(() {
                            MyUser.deleteList(tabIndex);
                            databaseUpdate(MyUser.email, 'data', MyUser.data);
                            if (tabIndex != 0) {
                              tabIndex--;
                            }
                          });
                        }
                      },
                      child: Text(
                        'Delete List',
                        style: MyTextStyles.small(forList: false),
                      )),
                  PopupMenuItem(
                      onTap: () {
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        signout().then((value) {
                          Navigator.of(context).pop();
                          Navigator.of(context).popAndPushNamed(MyConstants.loginRoute);
                        }).onError((error, stackTrace) {
                          Navigator.of(context).pop();
                          showDialog(
                            context: context,
                            builder: (context) => MyPopUp(message: error.toString(), context: context),
                          );
                        });
                      },
                      child: Text(
                        'Logout',
                        style: MyTextStyles.small(forError: true),
                      )),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: MyColors.black,
        body: Column(
          children: [
            SizedBox(height: MyConstants.gapBetween),
            Center(
              child: Container(
                decoration: const BoxDecoration(
                  color: MyColors.darkGrey,
                  borderRadius: BorderRadius.all(Radius.circular(17)),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: TabBar(
                        onTap: (value) {
                          tabIndex = value;
                        },
                        tabs: createTabs(),
                        isScrollable: true,
                        indicatorColor: MyColors.pink,
                        labelColor: MyColors.pink,
                        unselectedLabelColor: MyColors.whiteFaded,
                      ),
                    ),
                    const VerticalDivider(
                      color: MyColors.teal,
                      thickness: 1,
                      width: 10,
                      indent: 2,
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                            context: context, builder: (context) => newListPopup(onNewListCreated, context, newListController));
                      },
                      child: Text('Add List+',
                          style: TextStyle(fontSize: getTabSize(), fontWeight: FontWeight.bold, color: MyColors.teal)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: MyConstants.gapBetween),
            Expanded(
              child: TabBarView(
                children: createTabview(),
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => newTaskPopup(context, onTaskCreate, newTaskTitleController, newTaskDescController),
            );
          },
          backgroundColor: MyColors.pink,
          child: const Icon(Icons.add, color: MyColors.white),
        ),
      ),
    );
  }

  void onTaskCreate() {
    setState(() {
      MyUser.createTask(tabIndex, newTaskTitleController.text, newTaskDescController.text);
      databaseUpdate(MyUser.email, 'data', MyUser.data);
    });
  }

  void onNewListCreated() {
    setState(() {
      MyUser.createList(newListController.text);
      databaseUpdate(MyUser.email, 'data', MyUser.data);
    });
  }

  void onTaskUpdate(int listpos, int taskpos) {
    setState(() {
      MyUser.taskUpdate(listpos, taskpos, newTaskTitleController.text, newTaskDescController.text);
      databaseUpdate(MyUser.email, 'data', MyUser.data);
    });
  }

  double getTabSize() {
    double size = MediaQuery.of(context).size.width;
    if (size > 750) {
      return 22;
    } else if (size > 650) {
      return 20;
    } else if (size > 550) {
      return 19;
    }
    return 17;
  }

  List<Tab> createTabs() {
    List<Tab> tablist = [];

    for (int i = 0; i < MyUser.data.length; i++) {
      tablist.add(Tab(
          child: Text(
        MyUser.data[i][MyConstants.listname] ?? 'no data',
        style: TextStyle(fontSize: getTabSize(), fontWeight: FontWeight.bold),
      )));
    }
    return tablist;
  }

  List<Widget> createTabview() {
    List<Widget> tasklist = [];
    for (int i = 0; i < MyUser.data.length; i++) {
      if (MyUser.data[i][MyConstants.data].length == 0) {
        tasklist.add(
          const Center(child: Text('Create Your\n First Task', style: TextStyle(color: MyColors.lightGrey, fontSize: 35))),
        );
      } else {
        tasklist.add(ListView.builder(
          itemCount: MyUser.data[i][MyConstants.data].length,
          itemBuilder: (context, index) {
            return MyTask(
              value: MyUser.data[i][MyConstants.data][index][MyConstants.taskcompleted] == 'y' ? true : false,
              title: MyUser.data[i][MyConstants.data][index][MyConstants.taskname],
              desc: MyUser.data[i][MyConstants.data][index][MyConstants.taskdesc],
              listpos: i,
              taskpos: index,
              onDelete: () {
                setState(() {
                  MyUser.deleteTask(i, index);
                  databaseUpdate(MyUser.email, 'data', MyUser.data);
                });
              },
              onEdit: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    newTaskTitleController.text = MyUser.data[i][MyConstants.data][index][MyConstants.taskname];
                    newTaskDescController.text = MyUser.data[i][MyConstants.data][index][MyConstants.taskdesc];
                    return newTaskPopup(context, () {
                      setState(() {
                        MyUser.taskUpdate(i, index, newTaskTitleController.text, newTaskDescController.text);
                        databaseUpdate(MyUser.email, 'data', MyUser.data);
                      });
                    }, newTaskTitleController, newTaskDescController);
                  },
                );
              },
            );
          },
        ));
      }
    }
    return tasklist;
  }
}
