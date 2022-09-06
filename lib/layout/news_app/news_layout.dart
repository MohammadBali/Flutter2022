import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/news_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/news_app/cubit/states.dart';
import 'package:newflutter_2022/modules/news_app/search/search_screen.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/cubit/cubit.dart';
import 'package:newflutter_2022/shared/network/remote/dio_helper.dart';

class NewsLayout extends StatelessWidget {
  const NewsLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state)
      {},

      builder: (context,state)
      {
        var cubit=NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: cubit.AppBarTitle[cubit.currentIndex],
            actions:
            [
              IconButton(
                icon: Icon(Icons.search, size: 26,),
                onPressed: ()
                {
                  navigateTo(context,SearchScreen());
                },
              ),

              IconButton(
                icon: Icon(Icons.brightness_2_rounded, size: 26,),
                onPressed: ()
                {
                  AppCubit.get(context).ChangeTheme();
                },
              )

            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            items: cubit.bottomItems,

            onTap: (index)
            {
              cubit.changeBottomNavBar(index);
            },
          ),

          body: cubit.screens[cubit.currentIndex],
        );
      }
    );
  }
}

