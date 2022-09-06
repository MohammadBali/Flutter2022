import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/modules/counter_app/counter/cubit/states.dart';

class CounterCubit extends Cubit<CounterStates>
{
  CounterCubit(): super(CounterInitialState());

  int counter=1;

  static CounterCubit get(context) => BlocProvider.of(context);   //Creating an instance of this class for ease of use, can be accessed anytime without the need to create an object.

  void minus()
  {
    counter --;

    emit(CounterMinusState(counter));
  }

  void plus()
  {
    counter++;

    emit(CounterPlusState(counter));
  }

}