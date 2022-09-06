import 'package:flutter/material.dart';
import 'package:newflutter_2022/models/user/user_model.dart';



class UsersScreen extends StatelessWidget {
  // const UsersScreen({Key? key}) : super(key: key);
  final List<UserModel> users=[
    UserModel(id: 1, name: 'Mohammed', phone: '+963957528669'),
    UserModel(id: 2, name: 'Moneb', phone: '+963927524619'),
    UserModel(id: 3, name: 'Rida', phone: '+963957528664'),
    UserModel(id: 4, name: 'Marem', phone: '+963927528662'),
    UserModel(id: 5, name: 'Ruba', phone: '+963957422161'),
    UserModel(id: 6, name: 'Dima', phone: '+963966128626'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[300],
        title: Text('Users'),
      ),

      body: ListView.separated(
          itemBuilder: (context, index) => DataItem(users[index]),
          separatorBuilder: (context, index) => Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[200],
          ),
          itemCount: users.length
      ),
    );
  }


  Widget DataItem(UserModel user) => Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue,
              child: Text(
                '${user.id}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(width: 10,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${user.name}',
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 3,),
                Text(
                    '${user.phone}'
                ),
              ],
            ),
          ],
        ),

      ],
    ),
  );
}
