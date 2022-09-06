import 'package:newflutter_2022/models/shop_app/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}

class ShopSuccessHomeDataState extends ShopStates{}

class ShopErrorHomeDataState extends ShopStates
{
  final String error;

  ShopErrorHomeDataState(this.error);

}


class ShopLoadingCategoriesState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates
{
  final String error;

  ShopErrorCategoriesState(this.error);

}


class ShopSuccessFavouritesState extends ShopStates{}

class ShopErrorFavouritesState extends ShopStates
{
  final String error;

  ShopErrorFavouritesState(this.error);

}


class ShopChangeFavouritesState extends ShopStates{}


class ShopLoadingGetFavouritesState extends ShopStates{}

class ShopSuccessGetFavouritesState extends ShopStates{}

class ShopErrorGetFavouritesState extends ShopStates
{
  final String error;

  ShopErrorGetFavouritesState(this.error);

}


class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates
{}

class ShopErrorUserDataState extends ShopStates
{
  final String error;

  ShopErrorUserDataState(this.error);

}


class ShopLoadingUserUpdateState extends ShopStates{}

class ShopSuccessUserUpdateState extends ShopStates
{
  final ShopLoginModel loginModel;

  ShopSuccessUserUpdateState(this.loginModel);
}

class ShopErrorUserUpdateState extends ShopStates
{
  final String error;

  ShopErrorUserUpdateState(this.error);

}