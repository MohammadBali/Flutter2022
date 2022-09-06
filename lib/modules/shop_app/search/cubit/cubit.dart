import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/models/shop_app/search_model.dart';
import 'package:newflutter_2022/modules/shop_app/search/cubit/states.dart';
import 'package:newflutter_2022/shared/components/constants.dart';
import 'package:newflutter_2022/shared/network/end_points.dart';
import 'package:newflutter_2022/shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit(): super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);

  SearchModel? model;

  void search (String text)
  {
    emit(SearchLoadingState());
    DioHelper.postData(
        url: SEARCH,
        token: token,
        data:
        {
          'text':text
        },
    ).then((value)
    {
      model= SearchModel.fromJson(value.data);

      print(value.data);
      emit(SearchSuccessState());
    }
    ).catchError((error)
    {
      print(error.toString());
      emit(SearchErrorState(error.toString()));
    });
  }
}