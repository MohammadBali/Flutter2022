import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newflutter_2022/layout/news_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/news_app/cubit/states.dart';
import 'package:newflutter_2022/shared/components/components.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var searchController=TextEditingController();

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {},

      builder: (context,state)
      {

        var list=NewsCubit.get(context).searchList;


        return Scaffold(
          appBar: AppBar(

          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children:
             [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchController,
                    keyboard: TextInputType.text,
                    label: 'Search',
                    prefix: Icons.search,


                    BorderStyle: const OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.deepOrange,
                        width: 2.0,
                      ),
                    ),

                    LabelStyle: const TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 1,
                    ),

                    PrefixIconColor: Colors.grey,

                    onSubmit: (String value)
                    {
                      NewsCubit.get(context).getSearch(value);
                    },
                    validate:(String? value)
                    {
                      if(value!.isEmpty)
                      {
                        return "Value can't be empty";
                      }
                      return null;
                    }
                ),
              ),
               articleBuilder(list, context, isSearch: true),
            ],
          ),
        );
      },
    );
  }
}


/*
defaultFormField(
  controller: Controller,
  keyboard: TextInputType.text,
  label: 'Search',
  prefix: Icons.search,

  onChanged: (String value)
  {
    NewsCubit.get(context).getSearch(value);
  },
  validate:(String? value)
  {
    if(value!.isEmpty)
    {
      return "Value can't be empty";
    }
    return null;
  }
),
 */