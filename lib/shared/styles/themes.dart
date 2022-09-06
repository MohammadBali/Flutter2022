import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:newflutter_2022/shared/styles/colors.dart';

ThemeData lightTheme(context) => ThemeData(
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      titleSpacing: 16.0,
      backgroundColor: Colors.white,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle:TextStyle(color: defaultColor, fontWeight: FontWeight.bold, fontSize: 20),


      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),

    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: defaultColor,
      elevation: 20,
    ),

    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //     backgroundColor: Colors.deepOrange
    // ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: defaultColor,
    ),



    textTheme: Theme.of(context).textTheme.apply(
      fontFamily: 'Jannah',
      bodyColor: Colors.black,
      displayColor: Colors.black,)

);


ThemeData darkTheme(context)=> ThemeData(

    backgroundColor: Colors.black38,
    primarySwatch: defaultColor,
    scaffoldBackgroundColor: Colors.black38,
    appBarTheme: const AppBarTheme(
      titleSpacing: 16.0,
      backgroundColor: Colors.black38,
      elevation: 0.0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle:TextStyle(color: defaultColor, fontWeight: FontWeight.bold, fontSize: 20),

      actionsIconTheme: IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.black38,
          statusBarIconBrightness: Brightness.light
      ),

    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.black38,
      selectedItemColor: defaultColor,
      unselectedIconTheme: IconThemeData(color: Colors.white,),
      unselectedItemColor: Colors.white,
      elevation: 20,
    ),

    // floatingActionButtonTheme: const FloatingActionButtonThemeData(
    //     backgroundColor: Colors.deepOrange
    // ),

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: defaultColor,
    ),

    switchTheme: SwitchThemeData(

      thumbColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.white;
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        }
        return Colors.grey;
      }),
      trackColor: MaterialStateProperty.resolveWith((Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return Colors.black;
        }
        if (states.contains(MaterialState.disabled)) {
          return Colors.white;
        }
        return Colors.white;
      }),
    ),


    textTheme: Theme.of(context).textTheme.apply(
      bodyColor: Colors.white,
      fontFamily: 'Jannah',
      displayColor: Colors.white,)

);