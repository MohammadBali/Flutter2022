import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/models/shop_app/login_model.dart';
import 'package:newflutter_2022/modules/shop_app/login/cubit/states.dart';
import 'package:newflutter_2022/modules/shop_app/register/cubit/states.dart';
import 'package:newflutter_2022/shared/network/end_points.dart';
import 'package:newflutter_2022/shared/network/remote/dio_helper.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates>
{
  ShopRegisterCubit(): super(ShopRegisterInitialState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel; //Add the id,name,email .... , we kept it as ShopLoginModel since it has the same model so no need to change it.

  IconData suffix= Icons.visibility_outlined;

  bool isPasswordShown=true;

  void changePasswordVisibility()
  {
    isPasswordShown=!isPasswordShown;

    suffix= isPasswordShown? Icons.visibility_outlined :Icons.visibility_off_outlined;

    emit(ShopRegisterPasswordVisibilityChangeState());
  }

  void userRegister(
  {
    required String name,
    required String phone,
    required String email,
    required String password
  })
  {
    emit(ShopRegisterLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data:
      {
        'name':name,
        'phone':phone,
        'email':email,
        'password':password,
      },
    ).then((value)  //when we get the data.
    {
      print(value.data);
      loginModel=ShopLoginModel?.fromJson(value.data);
      emit(ShopRegisterSuccessState(loginModel!));
    }
      ).catchError((error)
      {
        print(error.toString());
        emit(ShopRegisterErrorState(error.toString()));
      }
      );
  }

}