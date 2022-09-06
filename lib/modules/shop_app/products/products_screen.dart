import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/states.dart';
import 'package:newflutter_2022/models/shop_app/categories_model.dart';
import 'package:newflutter_2022/models/shop_app/home_model.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/styles/colors.dart';
import 'package:string_extensions/string_extensions.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state) {},

        builder:(context,state)
        {
          return ConditionalBuilder(
              condition: ShopCubit.get(context).homeModel !=null && ShopCubit.get(context).categorieModel !=null,
              builder: (context)=> builderWidget(ShopCubit.get(context).homeModel, ShopCubit.get(context).categorieModel!, context),
              fallback:(context) => const Center(child: CircularProgressIndicator()),
          );
        },
    );
  }

  Widget builderWidget(HomeModel? model, CategoriesModel categorieModel, BuildContext context)
  {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [

          defaultCarouselSlider(
            items: model?.data?.banners?.map((e) => Image(
              image: NetworkImage('${e.image}'),
              width:double.infinity,
              fit: BoxFit.cover,
            )).toList(),
          ),

          const SizedBox(
            height: 15.0,
          ),

          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700
            ),
          ),

          const SizedBox(
            height: 5.0,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 100.0,

                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context,index)=>buildCategoryItem(categorieModel.data!.data![index]!),
                      separatorBuilder: (context,index)=> const SizedBox(width: 10,),
                      itemCount: categorieModel.data!.data!.length,
                  ),
                ),

                const SizedBox(
                  height: 10.0,
                ),

                const Text(
                  'New Products',
                  style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700
                  ),
                ),

                const SizedBox(
                  height: 15.0,
                ),


              ],
            ),
          ),

          Container(
            color: Colors.grey[300],
            child: GridView.count(  //Grid values won't be different from device to another.
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 1.0,
              crossAxisCount: 2,
              childAspectRatio: 1/1.59, // width / height  , keep changing until it gives no error
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children:List.generate(
                model!.data!.products!.length,(index) => buildGridProduct(model.data!.products![index], context),
              ),
            ),
          ),

        ],
      ),
    );

  }

  Widget buildCategoryItem(DataModel model)=> Stack(
    alignment: AlignmentDirectional.bottomCenter,
    children:
    [
       Image(
        image: NetworkImage(model.image!),
        width: 100,
        height: 100,
        fit: BoxFit.cover,
      ),
      Container(
        color: Colors.black.withOpacity(0.8),
        width: 100.0,
        child:  Text(
          model.name!.capitalize!,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
              color: Colors.white
          ),
        ),
      ),
    ],
  );

  Widget buildGridProduct(ProductModel model, BuildContext context)
  {
    return Container(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children:
            [
              Image(image: NetworkImage(model.image?? ''),
                width: double.infinity,
                height: 200,

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
          Padding(
            padding: const EdgeInsets.all(12.0),
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
                          ShopCubit.get(context).changeFavourites(model.id);
                        }
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
