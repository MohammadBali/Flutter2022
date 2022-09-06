import 'package:flutter/material.dart';

class bmiResultScreen extends StatelessWidget {
  final double result;
  final bool isMale;
  final int age;

  bmiResultScreen(
   {
     required this.result,
     required this.isMale,
     required this.age,

   });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo[300],
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: ()
          {
            Navigator.pop(context);
          },
        ),
        title: Text('Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Gender: ${ isMale? 'Male' : 'Female'}',
              style: TextStyle(fontSize: 25),
            ),
            Text(
              'Age: $age',
              style: TextStyle(fontSize: 25),
            ),
            Text(
                'Result: ${result.round()}',
              style: TextStyle(fontSize: 25),
            ),
          ],
        ),
      ),
    );
  }
}
