import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/cubit/cubit.dart';
import 'package:newflutter_2022/shared/cubit/states.dart';

import 'package:newflutter_2022/shared/components/constants.dart';

class NewTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context,states)
      {
        var tasks=AppCubit.get(context).NewTasks;
        var cubit=AppCubit.get(context);

        return ConditionalBuilder(
            condition: tasks!.length>0,
            builder: (context)=> Padding(
                padding: const EdgeInsets.all(16.0),
                child: ListView.separated(
                  itemBuilder: (context, index)
                  {
                    Map model= tasks[index];
                    return GestureDetector(
                        onTap: ()
                        {
                          print(tasks);
                        },
                        onDoubleTap: ()
                        {
                          print('Double Tapped, should Archive');
                          cubit.updateData(status: 'archived', id: model['id']);
                          DefaultToast(msg: 'Archived Successfully',color: Colors.grey,time: 2);
                        },

                        onLongPress: ()
                        {
                          print('Long Pressed, should get Done');
                          cubit.updateData(status: 'done', id: model['id']);
                          DefaultToast(msg: 'Added to Done Successfully',color: Colors.grey,time: 2);

                        },

                        child: buildTaskItem(tasks[index],context)
                    );
                  },
                  separatorBuilder: (context, index) => Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.amber[300],
                  ),
                  itemCount: tasks.length,
                )
            ),
            fallback: (context) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:
                  [
                    Icon(
                        Icons.menu,
                        size: 100.0,
                        color: Colors.grey,
                    ),

                    Text(
                      'No data yet, please insert',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w300
                      ),
                    ),
                  ],
                ),
              )
        );
      },
    );
  }
}
