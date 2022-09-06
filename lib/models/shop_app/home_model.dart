class HomeModel
{
  bool? status;
  HomeDataModel? data;

  HomeModel.fromJson(Map<String,dynamic> json)
  {
    status= json['status'];
    data= HomeDataModel.fromJson(json['data']);
  }

}
class HomeDataModel
{
  List<BannerModel>? banners=[];
  List<ProductModel>? products=[];
  HomeDataModel.fromJson(Map<String,dynamic> json)
  {

    json['banners'].forEach((element)   //It is a list, so we need to add each element, can be achieved by using forEach to get each element then add it using .add
    {
      banners?.add(BannerModel.fromJson(element));
    }
    );

    json['products'].forEach((element) //Same thing.
    {
      products?.add(ProductModel.fromJson(element));
    }
    );
  }
}

class BannerModel
{
  int? id;
  String? image;

  BannerModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    image=json['image'];
  }
}

class ProductModel
{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount;

  String? image;
  String? name;
  late bool inFavorites;
  bool? inCart;


  ProductModel.fromJson(Map<String,dynamic> json)
  {
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];

  }
}