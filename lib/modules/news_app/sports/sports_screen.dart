import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:newflutter_2022/layout/news_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/news_app/cubit/states.dart';
import 'package:newflutter_2022/shared/components/components.dart';

class SportsScreen extends StatelessWidget {
  const SportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
        listener: (context,state)
        {},
        builder: (context,state)
        {

          var list=NewsCubit.get(context).sportsList;
          bool list2=false;
          if(list !=null)
          {
            list2= list.isNotEmpty;
          }
          else
          {
            list2=false;
          }
          return ConditionalBuilder(
            condition: list2==true,
            builder: (context)=> ListView.separated(
              physics: BouncingScrollPhysics(), //on the first item when scrolling up, blue thing won't show up, instead, it will bounce.
              itemBuilder: (context,index) => buildArticleItem(list![index]),
              separatorBuilder:(context,index) => Container(width: double.infinity, height: 1, color: HexColor('FFD700'),),
              itemCount: list!.length,
            ),
            fallback: (context)=> const Center(child: CircularProgressIndicator(color: Colors.black26,)),
          );
        }
    );
  }
}