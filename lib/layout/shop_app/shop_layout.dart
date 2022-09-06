import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/cubit.dart';
import 'package:newflutter_2022/layout/shop_app/cubit/states.dart';
import 'package:newflutter_2022/modules/shop_app/login/shop_login_screen.dart';
import 'package:newflutter_2022/modules/shop_app/search/search_screen.dart';
import 'package:newflutter_2022/shared/components/components.dart';
import 'package:newflutter_2022/shared/network/local/cache_helper.dart';

class ShopLayout extends StatelessWidget {
  const ShopLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(

      listener: (context,states) {},


      builder: (context,states)
      {
        var cubit= ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: const Text('Salla', style: TextStyle(),),
            actions:
            [
              IconButton(onPressed: (){navigateTo(context, SearchScreen());}, icon: const Icon(Icons.search_outlined))
            ],
          ),

          body: cubit.bottomScreens[cubit.currentIndex],

          bottomNavigationBar: BottomNavigationBar(
            onTap: (index)
            {
              cubit.changeBottom(index);
            },
            currentIndex: cubit.currentIndex,
            items:
            const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),

              BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Categories'),

              BottomNavigationBarItem(icon: Icon(Icons.favorite_outlined), label: 'Favourites'),

              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      }
      );
  }
}
