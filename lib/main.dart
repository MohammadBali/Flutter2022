import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/news_app/news_layout.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/shop_app/shop_layout.dart';
import 'package:newflutter_2022/layout/todo_app/todo_layout.dart';
import 'package:newflutter_2022/modules/bmi_app/bmi/bmi_screen.dart';
import 'package:newflutter_2022/modules/counter_app/counter/counter_screen.dart';
import 'package:newflutter_2022/modules/basics_app/home/homeScreen.dart';
import 'package:newflutter_2022/modules/basics_app/users/users_screen.dart';
import 'package:newflutter_2022/modules/shop_app/login/cubit/cubit.dart';
import 'package:newflutter_2022/modules/shop_app/login/shop_login_screen.dart';
import 'package:newflutter_2022/shared/components/constants.dart';
import 'package:newflutter_2022/shared/cubit/cubit.dart';
import 'package:newflutter_2022/shared/cubit/states.dart';
import 'package:newflutter_2022/shared/network/local/cache_helper.dart';
import 'package:newflutter_2022/shared/network/remote/dio_helper.dart';
import 'package:newflutter_2022/shared/styles/themes.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'modules/basics_app/login/login_screen.dart';
import 'modules/basics_app/messenger/messenger_screen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'shared/bloc_observer.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();  //Makes sure that all the await and initializer get done before runApp

  Bloc.observer=MyBlocObserver();  //Running Bloc Observer which prints change in states and errors etc...  in console

  DioHelper.init();  //Starting Dio.

  await CacheHelper.init();  //Starting CacheHelper, await for it since there is async,await in .init().

  bool? isDark= CacheHelper.getData(key: 'isDarkTheme');   //Caching the last ThemeMode
  isDark ??= true;

  bool? onBoarding= CacheHelper.getData(key: 'onBoarding');  //To get if OnBoarding screen has been shown before, if true then straight to Login Screen.
  onBoarding ??= false;

   print(CacheHelper.getData(key: 'token'));

   if(CacheHelper.getData(key: 'token') != null)
     {
       token=CacheHelper.getData(key: 'token'); // Get User Token
     }

  Widget widget;

  if(onBoarding ==true) //OnBoarding Screen has been shown before
    {
     if(token.isNotEmpty)  //Token is there, so Logged in before
     {
       widget= const ShopLayout(); //Straight to Home Page.
     }
     else
     {
       widget=ShopLoginScreen();
     }
    }
  else //Not shown onBoarding before
    {
      widget= onBoardingScreen();
    }

  runApp(MyApp(isDark:isDark, homeWidget:widget));
}


class MyApp extends StatelessWidget {

  final bool isDark;
  final Widget homeWidget;
  MyApp({required this.isDark, required this.homeWidget,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        //BlocProvider(create: (BuildContext context) => NewsCubit()..getBusiness()..getSports()..getScience()),

         BlocProvider(create: (BuildContext context) => AppCubit()..ChangeTheme(ThemeFromState: isDark) ),

        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavourites()..getUserData() ),
      ],
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state){},

        builder: (context,state)
        {
          return MaterialApp(
            theme: lightTheme(context),
            darkTheme: darkTheme(context),

            themeMode:  ThemeMode.light, //AppCubit.get(context).isDarkTheme? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: homeWidget,  //The Home widget will be passed by from main.
          );
        },
      ),
    );
  }

}


