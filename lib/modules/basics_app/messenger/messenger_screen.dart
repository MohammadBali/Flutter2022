import 'package:flutter/material.dart';

class  MessengerScreen extends StatelessWidget {
  const MessengerScreen ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleSpacing: 20,

        title: Row(
          children: [
            CircleAvatar(
              radius: 25.0,
              backgroundImage: NetworkImage('https://www.biography.com/.image/t_share/MTY2OTU1MzIzNzkyMzAzMTIz/bb_king_photo_onekindfa_305rgbbbking_universal_music_group_promojpg.jpg'),
            ),
            SizedBox(width: 15,),
            Text(
              'Chats',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
          ],
        ),

        actions: [
          IconButton(
            onPressed: () {  },
            icon: CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.blue,
              child: Icon(
                  Icons.camera_alt,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: (){},
            icon: CircleAvatar(
              radius: 15.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.edit,
                size: 16.0,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10)
                ),
                   padding: EdgeInsets.all(5),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 5,),
                    Text(
                        'Search',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,

                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) => buildStoryItem(),
                  separatorBuilder: (context,index)=> SizedBox(width: 10),
                  itemCount: 10,
                ),
              ),

              SizedBox(
                height: 20,
              ),

              ListView.separated(
                  physics: NeverScrollableScrollPhysics(),  //SingleChildScrollView will work, so this shouldn't scroll.
                  shrinkWrap: true,  // IN order to get all the data to be scrolled, and SingleChildScrollView under Padding will scroll the screen.
                  itemBuilder: (context,index) => buildChatItem(),
                  separatorBuilder: (context,index) => SizedBox(height: 5,),
                  itemCount: 10
              ),



            ],
          ),
        ),
      ),

    );
  }

  Widget buildChatItem() => Row(
    children: [
      Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          CircleAvatar(
            radius: 30.0,
            backgroundImage: NetworkImage('https://i1.sndcdn.com/avatars-000278302555-myplha-t500x500.jpg'),

          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(bottom: 2.5, end: 2.5,),
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),

      SizedBox(width: 10),

      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'John Mayer',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: 3,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Jam with me',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Container(
                    width: 7,
                    height: 7,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue
                    ),
                  ),
                ),

                Text('2.00 PM'),
              ],
            ),
          ],
        ),
      ),
    ],
  );
  Widget buildStoryItem() => Container(
    width: 60.0, //Double the amount of the Circular avatar -> the limit of the text underneath it is the same as photo, we put it twice -> 30x2
    child: Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundImage: NetworkImage('https://i.guim.co.uk/img/media/472f92ecffab09f78626f9e9844de303557af106/0_165_5000_2999/master/5000.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=89953fb0bc327d57b16f0406bb47c435'),

            ),

            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 2.5, end: 2.5,),
              child: CircleAvatar(
                radius: 8,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Text(
          'Eric Clapton',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}
