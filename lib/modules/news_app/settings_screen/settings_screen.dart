import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/news_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/news_app/cubit/states.dart';
import 'package:newflutter_2022/main.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state)
      {
      },

      builder: (context,state)
        {
          var cubit= NewsCubit.get(context);
          return Padding(
            padding: const EdgeInsetsDirectional.only(start: 20, end: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children:
              const [
                // Expanded(
                //   child: Text(
                //       'Dark Mode',
                //   style:TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                //     ),
                // ),

              ],
            ),
          );
        },
    );
  }
}