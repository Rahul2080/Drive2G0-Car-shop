import 'dart:convert';


import 'package:drive2go/Repository/ModelClass/LoginModel.dart';
import 'package:drive2go/Repository/ModelClass/NearByRentVehiclesModel.dart';
import 'package:http/http.dart';

import '../ModelClass/AllRentVehiclesModel.dart';
import '../ModelClass/UserModel.dart';
import 'Api_client.dart';





class UserApi {
  ApiClient apiClient = ApiClient();


  Future<UserModel> getuser(String name ,String email,String phonenumber,String password) async {
    String trendingpath ='http://45.159.221.50:8868/api/signup';

    var body ={
      "fullName":name,
      "email":email,
      "phone":phonenumber,
      "password":password
    };
    print("welcome"+body.toString());
    Response response = await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));


    return UserModel.fromJson(jsonDecode(response.body));
  }

  Future<LoginModel> getLogin(String email,String password) async {
    String trendingpath ='http://45.159.221.50:8868/api/signin';

    var body ={
      "email": email,
      "password": password
    };
    print("welcome"+body.toString());
    Response response = await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));


    return LoginModel.fromJson(jsonDecode(response.body));
  }


  Future<List<NearByRentVehiclesModel>> getNearRentVehicles(String lat,String long) async {
    String trendingpath ='http://45.159.221.50:8868/api/get-nearby-vehicles?latitude=$lat&longitude=$long';

    var body ={

    };
    print("welcome"+body.toString());
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));


    return NearByRentVehiclesModel.listFromJson(jsonDecode(response.body));
  }

  Future<List<AllRentVehiclesModel>> getAllRentVehicles() async {
    String trendingpath ='http://45.159.221.50:8868/api/get-vehicles';

    var body ={

    };
    print("welcome"+body.toString());
    Response response = await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));


    return AllRentVehiclesModel.listFromJson(jsonDecode(response.body));
  }
}