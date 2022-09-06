import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:newflutter_2022/shared/cubit/cubit.dart';
import 'package:swipedetector_nullsafety/swipedetector_nullsafety.dart';
import 'package:url_launcher/url_launcher.dart';

//Button Like LOGIN
Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.blue, // Colors.blueGrey.withOpacity(0.4),
  bool isUpper = true,
  double radius = 5.0,  //was 10
  double height = 50.0, // was 40
  required void Function()? function,
  required String text,
}) =>
    Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(radius),
      ),
      width: width,
      height: height,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpper ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );


//---------------------------------------------------------------------------------------------------\\

Widget defaultTextButton({required void Function()? onPressed, required String text})
=>TextButton(
    onPressed: onPressed,
    child: Text(text.toUpperCase())
);



//--------------------------------------------------------------------------------------------------\\

//TextFormField like password..
Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType keyboard,
  required String label,
  required IconData prefix,
  required String? Function(String?)? validate,
  IconData? suffix,
  bool isObscure = false,
  bool isClickable = true,
  void Function(String)? onSubmit,
  void Function()? onPressedSuffixIcon,
  void Function()? onTap,
  void Function(String)? onChanged,
  void Function(String?)? onSaved,
  InputBorder? FocusedBorderStyle,
  InputBorder? BorderStyle,
  TextStyle? LabelStyle,
  Color? PrefixIconColor,
  TextInputAction? InputAction,
}) =>
    TextFormField(
      controller: controller,
      obscureText: isObscure,
      keyboardType: keyboard,
      onFieldSubmitted: onSubmit,
      textInputAction: InputAction,
      validator: validate,
      enabled: isClickable,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        focusedBorder: FocusedBorderStyle,
        enabledBorder: BorderStyle,
        labelStyle: LabelStyle,
        labelText: label,
        prefixIcon: Icon(prefix, color: PrefixIconColor,),
        suffixIcon: IconButton(
          onPressed: onPressedSuffixIcon,
          icon: Icon(suffix),
        ),
      ),
    );


//--------------------------------------------------------------------------------------------------\\


Widget buildTaskItem(Map model, BuildContext context) => Dismissible(
      key: Key(model['id'].toString()),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.brown.withOpacity(0.7),
              child: Text(
                '${model['id']}',
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model['title']}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${model['date']}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              '${model['time']}',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      onDismissed: (Direction) {
        print('On Dismissed activated');
        AppCubit.get(context).deleteData(id: model['id']);
        DefaultToast(msg: 'Deleted Successfully', color: Colors.grey, time: 2);
      },
    );


//--------------------------------------------------------------------------------------------------\\

//DefaultToast message
Future<bool?> DefaultToast({
  required String msg,
  ToastStates state=ToastStates.DEFAULT,
  ToastGravity position = ToastGravity.BOTTOM,
  Color color = Colors.grey,
  Color textColor= Colors.white,
  Toast length = Toast.LENGTH_SHORT,
  int time = 1,
}) =>
    Fluttertoast.showToast(
      msg: msg,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: time,
      toastLength: length,
      backgroundColor: chooseToastColor(state),
      textColor: textColor,
    );

enum ToastStates{SUCCESS,ERROR,WARNING, DEFAULT}

Color chooseToastColor(ToastStates state) {
  switch (state)
  {
    case ToastStates.SUCCESS:
      return Colors.green;
      break;

    case ToastStates.ERROR:
      return Colors.red;
      break;

    case ToastStates.DEFAULT:
      return Colors.grey;

    case ToastStates.WARNING:
      return Colors.amber;
      break;


  }
}
//--------------------------------------------------------------------------------------------------\\

//Default URL Launcher, it takes the link to be opened.
Future<void> _launchUrl(String ur) async
{
  final Uri url = Uri.parse(ur);
  if (!await launchUrl(url))
  {
    throw 'Could not launch $url';
  }
}

//--------------------------------------------------------------------------------------------------\\

//Article item, each item that has the news title and time and pic.
Widget buildArticleItem(article)
{
  //To Format Time
  var x=DateTime.tryParse(article['publishedAt']);
  final DateFormat formatter = DateFormat.yMd().add_jm();
  final String formatted = formatter.format(x!);

  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: GestureDetector(
      onTap: ()
      {
        _launchUrl(article['url']);
      },
      child: Row(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                10.0,
              ),
              image: DecorationImage(
                image: NetworkImage('${article['urlToImage']}'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      '${article['title']}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      formatted,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}



//--------------------------------------------------------------------------------------------------\\

//The Builder for the articles, with conditional Builder.

Widget articleBuilder(list,context, {bool isSearch=false})
{
  bool list2=false;
  if(list !=null)
  {
    list2= list.isNotEmpty;
  }
  else
  {
    list2=false;
  }
  return ConditionalBuilder(
    condition: list2==true ,
    builder: (context)=> Expanded(child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(), //on the first item when scrolling up, blue thing won't show up, instead, it will bounce.
        itemBuilder: (context,index) => buildArticleItem(list![index]),
        separatorBuilder:(context,index) => Container(width: double.infinity, height: 1, color: HexColor('FFD700'),),
        itemCount: list!.length,
      ),),
    fallback: (context)=> isSearch?  Container() : const Center(child: CircularProgressIndicator(color: Colors.black26,)),
  );
}



//--------------------------------------------------------------------------------------------------\\


// Navigate to a screen, it takes context and a widget to go to.

void navigateTo( BuildContext context, Widget widget) =>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget)
);

//--------------------------------------------------------------------------------------------------\\

// Navigate to a screen and distroy the ability to go back
void navigateAndFinish(context,Widget widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget),
    (route) => false,  // The Route that you came from, false will distroy the path back..
);


//--------------------------------------------------------------------------------------------------\\


//--------------------------------------------------------------------------------------------------\\

//A slider that takes a list of items to slide them and bunch of options.
Widget defaultCarouselSlider(
    {
      required List<Widget>? items,
      double height=250,
      int firstPage=0,  //Which page to start from.
      double viewportFraction=1, //1 will make the image take the whole place, 0.9 will show some of the other pictures from left and right.
      bool infiniteScroll=true, //Will scroll back to the beginning when ended.
      bool isReverse=false,
      bool autoplay=true, //Will slide by it self.
      Duration autoPlayInterval= const Duration(seconds: 5),
      Duration autoPlayAnimationDuration= const Duration(seconds: 3),
      Curve autoPlayCurve= Curves.fastOutSlowIn,
      Axis scrollDirection=Axis.horizontal,
    }
    )
{
  return CarouselSlider(
      items: items,
      options: CarouselOptions(
        height: height,
        initialPage: firstPage,
        viewportFraction: viewportFraction,
        enableInfiniteScroll: infiniteScroll,
        reverse: isReverse,
        autoPlay: autoplay,
        autoPlayInterval: autoPlayInterval,
        autoPlayAnimationDuration:autoPlayAnimationDuration,
        autoPlayCurve:autoPlayCurve,
        scrollDirection: scrollDirection,

      ),
  );
}

//--------------------------------------------------------------------------------------------------\\

//Default Divider for ListViews ...
Widget myDivider() => Container(height: 1, width: double.infinity , color: Colors.grey,);