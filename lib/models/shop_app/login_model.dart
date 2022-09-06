class ShopLoginModel
{
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModel.fromJson(Map<String,dynamic>json)  //Using named constructor again, for the data field, if not empty then add the values to it through calling named constructor, elsewise null.
  {
    status=json['status'];
    message=json['message'];
    data= json['data'] !=null ? UserData.fromJson(json['data']) : null;   //UserData.fromJson(json['data']);
  }
}

class UserData
{
   int? id;
   String? name;
   String? email;
   String? phone;
   String? image;
   int? points;
   int? credits;
   String? token;

  UserData.fromJson(Map<String,dynamic> json)  //Named constructor, same as default constructor but has a name.  fromJason is the Map that contains id,name etc but named like this for no good reason.
  {
    id=json['id'];
    name=json['name'];
    email=json['email'];
    phone=json['phone'];
    image=json['image'];
    points=json['points'];
    credits=json['credits'];
    token=json['token'];

  }
}