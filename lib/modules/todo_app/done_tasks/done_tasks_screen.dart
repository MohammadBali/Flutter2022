import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/cubit/cubit.dart';
import 'package:newflutter_2022/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,states){},
      builder: (context,states)
      {
        var tasks=AppCubit.get(context).DoneTasks;
        var cubit=AppCubit.get(context);
        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.separated(
              itemBuilder: (context, index)
              {
                return GestureDetector(
                    onTap: ()
                    {
                      print(tasks);
                    },


                    child: buildTaskItem(tasks![index],context)
                );
              },
              separatorBuilder: (context, index) => Container(
                width: double.infinity,
                height: 1,
                color: Colors.amber[300],
              ),
              itemCount: tasks!.length,
            )
        );
      },
    );
  }
}
