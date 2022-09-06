import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/modules/counter_app/counter/cubit/cubit.dart';
import 'package:newflutter_2022/modules/counter_app/counter/cubit/states.dart';

class CounterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => CounterCubit(),
      child: BlocConsumer<CounterCubit, CounterStates>(
        listener: (context, state) {

          if (state is CounterPlusState) {
            // print('Plus State, value now is ${state.counter}');
          }

          if (state is CounterMinusState) {
            // print('Minus State,  value now is ${state.counter}');
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Simple Counter',
              ),
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).minus();

                      },
                      child: Text(
                        'MINUS',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[900],
                        ),
                      )),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${CounterCubit.get(context).counter}',
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Colors.indigo),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        CounterCubit.get(context).plus();
                      },
                      child: Text(
                        'PLUS',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey[900],
                        ),
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
