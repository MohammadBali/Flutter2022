

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/news_app/cubit/states.dart';
import 'package:newflutter_2022/modules/news_app/business/business_screen.dart';
import 'package:newflutter_2022/modules/news_app/science/science_screen.dart';
import 'package:newflutter_2022/modules/news_app/settings_screen/settings_screen.dart';
import 'package:newflutter_2022/modules/news_app/sports/sports_screen.dart';
import 'package:newflutter_2022/shared/network/remote/dio_helper.dart';

import '../../../main.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    const BottomNavigationBarItem(icon: Icon(Icons.science_outlined), label: 'Science'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  List<Widget> screens=
  [
    const BusinessScreen(),
    const SportsScreen(),
    const ScienceScreen(),
    const SettingsScreen(),
  ];

  List<Widget>AppBarTitle=
  [
    const Text('Business Screen'),
    const Text('Sports Screen'),
    const Text('Science Screen'),
    const Text('Settings')
  ];

  void changeBottomNavBar(index)
  {
    currentIndex=index;

    emit(NewsBottomNavBarState());
  }

  List <dynamic>? businessList;

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    print('GettingBusiness');


        DioHelper.getData(
          url: 'v2/top-headlines',
          query:
          {
            'country':'us',
            'category':'business',
            'apikey':'ea5f5e12c0864c658c9f06f37a10003b', //'446d8385b2eb42989c1d68592317cf21',
          },
        )
            .then((value)
        {

          businessList=value.data['articles'];

          print(value.data['articles'][0]['title']);

          emit(NewsGetBusinessSuccessState());
        })
            .catchError((error)
        {
          print(error.toString());
          emit(NewsGetBusinessErrorState(error.toString()));
        });

  }


  List <dynamic>? sportsList;

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    print('GettingSports');

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'us',
        'category':'sports',
        'apikey':'ea5f5e12c0864c658c9f06f37a10003b', //'446d8385b2eb42989c1d68592317cf21',
      },
    )
        .then((value)
    {
      sportsList=value.data['articles'];

      print(value.data['articles'][0]['title']);

      emit(NewsGetSportsSuccessState());
    })
        .catchError((error)
    {
      print(error.toString());
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }


  List <dynamic>? scienceList;

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    print('GettingScience');

    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'us',
        'category':'science',
        'apikey': 'ea5f5e12c0864c658c9f06f37a10003b', //'446d8385b2eb42989c1d68592317cf21',
      },
    ).then((value)
    {
      scienceList=value.data['articles'];

      print(value.data['articles'][0]['title']);

      emit(NewsGetScienceSuccessState());
    })
        .catchError((error)
    {
      print(error.toString());
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }


  List <dynamic>? searchList;

  void getSearch(String value)
  {
    // https://newsapi.org/v2/everything?q=ronaldo&sortBy=publishedAt&apiKey=446d8385b2eb42989c1d68592317cf21

    emit(NewsGetSearchLoadingState());

    print('GettingSearch');

    DioHelper.getData(
      url: 'v2/everything',
      query:
      {
        'q':value,
        'sortBy':'publishedAt',
        'apikey': 'ea5f5e12c0864c658c9f06f37a10003b', //'446d8385b2eb42989c1d68592317cf21',
      },
    ).then((value)
    {
      searchList=value.data['articles'];

      print(value.data['articles'][0]['title']);

      emit(NewsGetSearchSuccessState());
    })
        .catchError((error)
    {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }

}
