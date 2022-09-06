import 'package:dio/dio.dart';

// Dio is like an API helper to get data, we declare in the init() giving the url to get the data from, and it getData we give him the method and queries.
class DioHelper
{
  static Dio ? dio;

  static init()
  {
    dio=Dio(
      BaseOptions(
        baseUrl: 'https://student.valuxapps.com/api/',   // Perilously was 'http://newsapi.org/',
        receiveDataWhenStatusError: true,
        receiveTimeout:50000,
        connectTimeout: 30000,
      ),
    );
  }

  static Future<Response> getData({required String url,  Map<String,dynamic>? query, String lang='en', String? token,}) async
  {
    dio?.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };

    print('in getData');
    return await dio!.get(
        url,
      queryParameters: query
    ); //path is the method
  }

  static Future<Response> postData(
  {required String url, Map<String,dynamic>?query,  required Map<String,dynamic> data, String lang='en', String? token,  }) async
  {
    dio?.options.headers=
    {
      'Content-Type':'application/json',
        'lang':lang,
        'Authorization': token,
    };
    return await dio!.post(
      url,
      queryParameters: query,
      data: data,
    );
  }


  static Future<Response> putData(
      {required String url, Map<String,dynamic>?query,  required Map<String,dynamic> data, String lang='en', String? token,  }) async
  {
    dio?.options.headers=
    {
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization': token,
    };
    return await dio!.put(
      url,
      queryParameters: query,
      data: data,
    );
  }
}