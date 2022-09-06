import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/cubit.dart';
import 'package:newflutter_2022/modules/shop_app/search/cubit/cubit.dart';
import 'package:newflutter_2022/modules/shop_app/search/cubit/states.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/styles/colors.dart';

import '../../../models/shop_app/search_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey= GlobalKey<FormState>();
    var searchController= TextEditingController();
    return  BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context,state)
        {},

        builder: (context,state)
        {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children:
                  [
                    defaultFormField(
                        controller: searchController,
                        keyboard: TextInputType.text,
                        label: 'Search',
                        prefix: Icons.search,
                        validate: (String? value)
                        {
                          if(value!.isEmpty)
                            {
                              return 'Enter Data';
                            }
                          return null;
                        },

                      onSubmit: (String text)
                        {
                          if(formKey.currentState?.validate()==true)
                            {
                              SearchCubit.get(context).search(text);
                            }
                        }
                    ),

                    const SizedBox(height: 15,),

                    if(state is SearchLoadingState)
                      const LinearProgressIndicator(color: Colors.deepOrange, backgroundColor: Colors.blueGrey,),

                    const SizedBox(height: 20,),

                    if(state is SearchSuccessState)
                    Expanded(
                        child:ListView.separated(
                          itemBuilder: (context,index) => buildSearchItem(SearchCubit.get(context).model!.data!.data![index], context),
                          separatorBuilder:(context,index)=> myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length,
                        ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      )

    );
  }

  Widget buildSearchItem(Product model, BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: 120,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:
          [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children:
              [
                Image(image: NetworkImage(model.image?? ''),
                  width: 120,
                  height: 120,
                ),
              ],
            ),

            const SizedBox(width: 20,),


            Expanded(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.name!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14.0,
                      height: 1.3,

                    ),
                  ),

                  const Spacer(),

                  Row(
                    children: [
                      Text(
                        '${model.price?.round()}',
                        style: const TextStyle(
                          color: defaultColor,
                          fontSize: 12.0,),
                      ),
                      const SizedBox(width: 5,),

                      const Spacer(),

                      IconButton(
                          padding: EdgeInsets.zero,
                          icon:  Icon(
                            ShopCubit.get(context).favourites[model.id]! ?  Icons.favorite: Icons.favorite_outline,
                            color: ShopCubit.get(context).favourites[model.id]! ?Colors.red : Colors.black,
                            size: 19,
                          ),
                          onPressed: ()
                          {
                            ShopCubit.get(context).changeFavourites(model.id!);
                          }
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
