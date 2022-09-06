import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/models/shop_app/login_model.dart';
import 'package:newflutter_2022/modules/shop_app/login/cubit/states.dart';
import 'package:newflutter_2022/shared/network/end_points.dart';
import 'package:newflutter_2022/shared/network/remote/dio_helper.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates>
{
  ShopLoginCubit(): super(ShopLoginInitialState());

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel; //Add the id,name,email ....

  IconData suffix= Icons.visibility_outlined;

  bool isPasswordShown=true;

  void changePasswordVisibility()
  {
    isPasswordShown=!isPasswordShown;

    suffix= isPasswordShown? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(ShopPasswordVisibilityChangeState());
  }

  void userLogin(
  {
    required String email,
    required String password
  })
  {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data:
      {
        'email':email,
        'password':password,
      },
    ).then((value)  //when we get the data.
    {
      print('bfff');
      print(value.data);
      loginModel=ShopLoginModel?.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel!));
    }
      ).catchError((error)
      {
        print('ERROR_IN_CUBIT_SIGN_IN_$error');
        emit(ShopLoginErrorState(error.toString()));
      }
      );
  }

}