import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/states.dart';
import 'package:newflutter_2022/models/shop_app/categories_model.dart';
import 'package:newflutter_2022/models/shop_app/change_favourites_model.dart';
import 'package:newflutter_2022/models/shop_app/favourites_model.dart';
import 'package:newflutter_2022/models/shop_app/home_model.dart';
import 'package:newflutter_2022/models/shop_app/login_model.dart';
import 'package:newflutter_2022/modules/shop_app/categories/categories_screen.dart';
import 'package:newflutter_2022/modules/shop_app/favourites/favourites_screen.dart';
import 'package:newflutter_2022/modules/shop_app/products/products_screen.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/components/constants.dart';
import 'package:newflutter_2022/shared/network/end_points.dart';
import 'package:newflutter_2022/shared/network/remote/dio_helper.dart';

import '../../../modules/shop_app/settings/settings_screen.dart';

class ShopCubit extends Cubit<ShopStates>
{
  ShopCubit(): super(ShopInitialState());


  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;

  List<Widget> bottomScreens=
  [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavouritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) //Changing the index of the Bottom Navigation Bar
  {
    currentIndex=index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  Map<int,bool> favourites={};  //List to add all the id's of products with a bool value if it is in the favorites or not.

  void getHomeData()
  {
    emit(ShopLoadingHomeDataState());
    
    DioHelper.getData(
        url: HOME,
        query: null,
        lang: 'en',
        token: token,
    ).then((value)
    {
       homeModel=HomeModel.fromJson(value.data);
       // printFullText(homeModel?.data?.banners![0].image);
       print(homeModel?.status);


       homeModel!.data!.products!.forEach((element)  //Looping each element of the products.
       {
         favourites.addAll(
             {
               element.id: element.inFavorites   //add the id of the element and if it is a favorite or not.
             });
       }
       );
       print(favourites.toString());

      emit(ShopSuccessHomeDataState());

    }
    ).catchError((error)
    {
      emit(ShopErrorHomeDataState(error.toString()));
      print(error.toString());
    });

  }

  CategoriesModel? categorieModel;

  void getCategoriesData()
  {
    emit(ShopLoadingCategoriesState());

    DioHelper.getData(
      url: GET_CATEGORIES,
      query: null,
      lang: 'en',
    ).then((value)
    {
      categorieModel=CategoriesModel.fromJson(value.data);
      print(categorieModel?.status);

      emit(ShopSuccessCategoriesState());

    }
    ).catchError((error)
    {
      emit(ShopErrorCategoriesState(error.toString()));
      print(error.toString());
    });

  }


  ChangeFavouritesModel? changeFavouritesModel;
  void changeFavourites(int productId)
  {
    favourites[productId]= ! favourites[productId]!; //Change the bool value in the list so the heart will show or not without reloading the page.

    emit(ShopChangeFavouritesState());

    DioHelper.postData(
        url: FAVOURITES,
        token: token,
        data: {
          'product_id':productId,
        }
    ).then((value)
    {
      changeFavouritesModel= ChangeFavouritesModel.fromJson(value.data);

      if(!changeFavouritesModel!.status!) // if Status was false, so for some reason it didn't change, undo the bool value change.
        {
          favourites[productId]= ! favourites[productId]!; //Same as above.

          DefaultToast(msg: 'Couldn\'t Change the value' ,state: ToastStates.ERROR);
        }
      else
        {
          getFavourites();  //Get the favorites items again if the change was successful.
        }
      print(value.data);
      emit(ShopSuccessFavouritesState());
    }).catchError((error)
    {
      favourites[productId]= ! favourites[productId]!; // If some other errors happen, undo.
      emit(ShopErrorFavouritesState(error));
    });
  }


  FavouritesModel? favouritesModel;

  void getFavourites()
  {
    emit(ShopLoadingGetFavouritesState());
    DioHelper.getData(
        url: FAVOURITES,
        token: token,
    ).then((value)
    {
      favouritesModel=FavouritesModel.fromJson(value.data);
      printFullText(value.data.toString());
      emit(ShopSuccessGetFavouritesState());
    }).catchError((error)
    {
      emit(ShopErrorGetFavouritesState(error));
    });
  }


  ShopLoginModel? userModel;

  void getUserData()
  {
    emit(ShopLoadingUserDataState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value)
    {
      userModel=ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name);
      // printFullText(value.data.toString());
      emit(ShopSuccessUserDataState());
    }).catchError((error)
    {
      emit(ShopErrorUserDataState(error));
    });
  }


  void updateUserData(
  {
    required  String name,
    required String email,
    required String phone,
  }
)
  {
    emit(ShopLoadingUserUpdateState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data:
      {
        'name':name,
        'email':email,
        'phone':phone
      },
    ).then((value)
    {
      userModel=ShopLoginModel.fromJson(value.data);

      print(userModel!.data!.name);
      // printFullText(value.data.toString());
      emit(ShopSuccessUserUpdateState(userModel!));
    }).catchError((error)
    {
      emit(ShopErrorUserUpdateState(error));
    });
  }


}