import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class homeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed:fun,),
        title: Text('Second Round'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.taxi_alert)),

        ],
      ),
      body: Container(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image(
                  image: NetworkImage('https://cdn.fanaticguitars.com/martin/210000000232/martin-d28-1_600.jpg'),
                width: 300,
                height: 300,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal:40 ),
                child: Container(
                  width: double.infinity,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.grey.withOpacity(0.7),
                  ) ,
                  clipBehavior: Clip.antiAliasWithSaveLayer,

                  child: Text(
                    'Martin D-28',
                    textAlign: TextAlign.center,
                    style: TextStyle(

                      fontSize:20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void fun()
  {
    print('hello');
  }
}