import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/states.dart';
import 'package:newflutter_2022/models/shop_app/favourites_model.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/styles/colors.dart';

class FavouritesScreen extends StatelessWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state)
      {},
      builder: (context,state)
      {
        var model= ShopCubit.get(context).favouritesModel!.data!;
        return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavouritesState,
            builder: (context) => ListView.separated(
              itemBuilder: (context,index) => buildFavItem(model.data![index].product!, context),
              separatorBuilder:(context,index)=> myDivider(),
              itemCount: model.data!.length,
            ),
            fallback:(context)=> const Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget buildFavItem(Product model, BuildContext context)
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
                if(model.discount !=0)
                  Container(
                    color: Colors.red,
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: const Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8.0,
                        color: Colors.white,

                      ),
                    ),
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

                      if(model.discount !=0)
                        Text(
                          '${model.oldPrice?.round()}',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 10.0,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),

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
