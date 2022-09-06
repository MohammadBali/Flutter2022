import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:newflutter_2022/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:newflutter_2022/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/cubit/cubit.dart';
import 'package:newflutter_2022/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';

import '../../modules/todo_app/new_tasks/new_tasks_screen.dart';
import '../../shared/components/constants.dart';




class HomeLayout extends StatelessWidget
{

  List<String> titles = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  var ScaffoldKey = GlobalKey<ScaffoldState>();
  var FormKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var DateController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(

      create: (BuildContext context) => AppCubit()..createDatabase(),  //.. is as if we saved AppCubit() in a variable then accessed the createDatabase().
      child: BlocConsumer<AppCubit,AppStates>(

        listener: (context,state)
        {
          if(state is AppInsertDatabaseState)
            {
              Navigator.pop(context);
              DefaultToast(msg: 'Inserted Successfully',color: Colors.grey,time: 2);
            }
        },
        builder: (context,state)
        {
          AppCubit cubit= AppCubit.get(context);
          return Scaffold(
            key: ScaffoldKey,
            appBar: AppBar(
              title: Text(titles[cubit.currentIndex]),
              backgroundColor: Colors.blueGrey[300],
            ),
            body: ConditionalBuilder(
              condition: state is! AppGetDatabaseLoadingState,
              builder: (context)=>cubit.screens[cubit.currentIndex],
              fallback: (context)=> Center(child: CircularProgressIndicator()),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blueGrey[300],
              onPressed: () {
                if (cubit.isBottomSheetShown)
                {
                  if (FormKey.currentState!.validate())
                  {

                    cubit.InsertIntoDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: DateController.text,
                    );
                  }
                } else {
                  print('not shown,will be shown, ${cubit.isBottomSheetShown}');
                //cubit.changeBottomSheetState( isShown: true, icon:Icons.edit);
                  ScaffoldKey.currentState?.showBottomSheet((context) {
                    return Container(
                      color: Colors.grey[100],
                      padding: EdgeInsets.all(20),
                      child: Form(
                        key: FormKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultFormField(
                                controller: titleController,
                                keyboard: TextInputType.text,
                                label: 'Task Title',
                                prefix: Icons.title,
                                validate: (String? data) {
                                  if (data!.isEmpty) {
                                    return "Title can't be empty";
                                  }

                                  return null;
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                controller: timeController,
                                keyboard: TextInputType.datetime,
                                isClickable: true,
                                label: 'Task Time',
                                prefix: Icons.watch_later_outlined,
                                validate: (String? data) {
                                  if (data!.isEmpty) {
                                    return "Time can't be empty";
                                  }

                                  return null;
                                },
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                }),
                            SizedBox(
                              height: 15,
                            ),
                            defaultFormField(
                                controller: DateController,
                                keyboard: TextInputType.datetime,
                                isClickable: true,
                                label: 'Task Date',
                                prefix: Icons.date_range_outlined,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(2023),
                                  ).then((value) {
                                    DateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                validate: (String? data) {
                                  if (data!.isEmpty) {
                                    return "Date can't be empty";
                                  }
                                  return null;
                                }),
                          ],
                        ),
                      ),
                    );
                  })
                      .closed
                      .then((value) {
                        cubit.changeBottomSheetState(isShown:false, icon:Icons.add);
                  });

                  cubit.changeBottomSheetState(isShown:true, icon:Icons.edit);

                }
              },
              child: Icon(cubit.FAB_Icon),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index)
              {
                cubit.changeIndex(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(Icons.menu), label: 'Tasks'),
                BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Done'),
                BottomNavigationBarItem(icon: Icon(Icons.archive_outlined), label: 'Archrived'),
              ],
            ),
          );
        }
      ),
    );
  }


}


