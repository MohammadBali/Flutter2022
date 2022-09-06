import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/modules/todo_app/archived_tasks/archived_tasks_screen.dart';
import 'package:newflutter_2022/modules/todo_app/done_tasks/done_tasks_screen.dart';
import 'package:newflutter_2022/modules/todo_app/new_tasks/new_tasks_screen.dart';
import 'package:newflutter_2022/shared/cubit/states.dart';
import 'package:newflutter_2022/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  List<Map<String, Object?>>? NewTasks = []; //List that contains all the new tasks from ToDo app.

  List<Map<String, Object?>>? DoneTasks = []; //List that contains all the Done tasks from ToDo app.

  List<Map<String, Object?>>? ArchivedTasks = []; //List that contains all the Archived tasks from ToDo app.

  bool isBottomSheetShown = false;
  IconData FAB_Icon = Icons.add;

  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen()
  ];

  void changeIndex(int index) {
    currentIndex = index;

    emit(AppChangeBottomNavBarState());
  }

  Database? database;

  void createDatabase() {
    openDatabase(
      'todo1.db',
      version: 1,
      onCreate: (database, version) async {
        print('database has been created');
        await database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
            .then((value) {
          print('Table tasks has been created.');
        }).catchError((error) {
          print(
              'an Error occurred when creating tasks table ${error.toString()}');
        });
      },
      onOpen: (database) {
        print('database has been opened.');
        getDatabase(database);
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }

  InsertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    await database?.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value has been Inserted successfully');
        emit(AppInsertDatabaseState());

        getDatabase(database);

      }).catchError((error) {
        print(
            'Error has occurred while insreting into database, ${error.toString()}');
      });
    });
  }

  void getDatabase(database)  {

    NewTasks=[];
    DoneTasks=[];
    ArchivedTasks=[];
    emit(AppGetDatabaseLoadingState());
    database?.rawQuery('SELECT * FROM tasks').then((value) async {

      
      value!.forEach( (element)
      {
        print('Current status is ${element['status']}');
        if(element['status'] == 'new')
          {
            print('adding to new');
            NewTasks!.add(element);
          }

        else if(element['status'] == 'done')
        {
          print('adding to done');
          DoneTasks!.add(element);
        }

        else
        {
          print('adding to archived');
          ArchivedTasks!.add(element);
        }
      }
      );
      emit(AppGetDatabase());
    });
  }


  void updateData({required String status, required int id}) async
  {
    print('ID IS: $id');
     database!.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id = ?',
        ['$status', id,])
         .then((value)
           {
             print('element to be updated');
             getDatabase(database);
             emit(AppUpdateDatabaseState());
           });
  }



  void deleteData({required int id}) async
  {
    print('in delete');
    database!.rawDelete(
        'DELETE FROM tasks WHERE id = ?',
        [id])
        .then((value)
    {
      getDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }

  void changeBottomSheetState({required bool isShown, required IconData icon}) {
    isBottomSheetShown = isShown;
    FAB_Icon = icon;

    emit(AppChangeBottomSheetBarState());
  }

  bool isDarkTheme=false;

  void ChangeTheme({bool? ThemeFromState})
  {
    if(ThemeFromState !=null)  //if a value is sent from main, then use it.. we didn't use CacheHelper because the value has already came from cache, then there is no need to..
      {
        isDarkTheme=ThemeFromState;
        emit(AppChangeThemeModeState());
      }
    else                      // else which means that the button of changing the theme has been pressed.
      {
        isDarkTheme= !isDarkTheme;
        CacheHelper.putBoolean(key: 'isDarkTheme', value: isDarkTheme).then((value)  //Put the data in the sharedPref and then emit the change.
        {
          emit(AppChangeThemeModeState());
        });
      }

  }
}
