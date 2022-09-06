import 'dart:math';

import 'package:flutter/material.dart';
import 'package:newflutter_2022/modules/bmi_app/bmi_result/bmiResult_screen.dart';
import 'package:newflutter_2022/shared/components/components.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({Key? key}) : super(key: key);

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {

  bool isMale=true;
  double height=180;
  int age=24;
  int weight=80;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Colors.indigo[300],

      ),

      body: Column(
        children: [

          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: ()
                        {
                          setState(() {
                            isMale=true;
                          });
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: isMale? Colors.amberAccent[100] : Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/male.png'),
                                height: 90,
                                width: 90,
                              ),
                              Text(
                                'MALE',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    SizedBox(width: 20,),

                    Expanded(
                      child: GestureDetector(
                        onTap: ()
                        {
                          setState(() {
                            isMale=false;
                          });
                        },
                        child: Container(
                        decoration: BoxDecoration(
                        color: !isMale? Colors.amberAccent[100] :Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                        ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image(
                                image: AssetImage('assets/images/female.png'),
                                height: 90,
                                width: 90,
                              ),
                              Text(
                                'FEMALE',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ),

          Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                          'HEIGHT',
                        style: TextStyle(
                          fontSize:25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      SizedBox(
                        height: 10,
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        mainAxisAlignment: MainAxisAlignment.center,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                              '${height.round()}',
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'CM',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300
                            ),
                          ),
                        ],
                      ),

                      Slider(
                        activeColor: Colors.black.withOpacity(0.8),
                        inactiveColor: Colors.blueGrey[200],
                        value: height,
                        min: 75,
                        max: 220,
                        onChanged: (value)
                        {
                          setState(() {
                            height=value;
                          });
                          print(value.round());
                        },
                      ),
                    ],
                  ),
                ),
              ),
          ),

          Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              'AGE',
                              style: TextStyle(
                                fontSize:25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Text(
                              '$age',
                              style: TextStyle(
                                fontSize:35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                FloatingActionButton(
                                    onPressed: ()
                                    {
                                      setState(() {
                                        age--;
                                      });
                                    },
                                  mini: true,
                                  child: Icon(Icons.remove),
                                  backgroundColor: Colors.brown[300],
                                ),

                                FloatingActionButton(
                                  onPressed: ()
                                  {
                                    setState(() {
                                      age++;
                                    });
                                  },
                                  mini: true,
                                  child: Icon(Icons.add),
                                  backgroundColor: Colors.blueGrey[200],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                    SizedBox(
                      width: 20,
                    ),
                    
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Text(
                              'WEIGHT',
                              style: TextStyle(
                                fontSize:25,
                                fontWeight: FontWeight.w400,
                              ),
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  '$weight',
                                  style: TextStyle(
                                    fontSize:35,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                Text(
                                    'kg',
                                style:TextStyle(fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                FloatingActionButton(
                                  onPressed: ()
                                  {
                                    setState(() {
                                      weight--;
                                    });
                                  },
                                  mini: true,
                                  child: Icon(Icons.remove),
                                    backgroundColor: Colors.brown[300]

                                ),

                                FloatingActionButton(
                                  onPressed: ()
                                  {
                                    setState(() {
                                      weight++;
                                    });
                                  },
                                  mini: true,
                                  child: Icon(Icons.add),
                                  backgroundColor: Colors.blueGrey[200],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ),

          Container(
            height: 50,
            width: double.infinity,
            color: Colors.indigo[300],
            child: MaterialButton(
                onPressed: ()
                {
                  double result= weight / pow(height/100 ,2);
                  navigateTo(context, bmiResultScreen(age: age, isMale: isMale, result: result,) );
                },
              child: Text(
                  'CALCULATE',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,

                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
