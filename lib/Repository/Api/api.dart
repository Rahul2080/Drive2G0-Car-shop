import 'dart:convert';

import 'package:drive2go/Repository/ModelClass/LoginModel.dart';
import 'package:drive2go/Repository/ModelClass/NearByRentVehiclesModel.dart';
import 'package:drive2go/main.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClass/AllRentVehiclesModel.dart';
import '../ModelClass/OrderRentVehicleModel.dart';
import '../ModelClass/UserModel.dart';
import 'Api_client.dart';

class UserApi {
  ApiClient apiClient = ApiClient();

  Future<UserModel> getuser(
      String name, String email, String phonenumber, String password) async {
    String trendingpath = 'http://45.159.221.50:8868/api/signup';

    var body = {
      "fullName": name,
      "email": email,
      "phone": phonenumber,
      "password": password
    };
    print("welcome" + body.toString());
    Response response =
        await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return UserModel.fromJson(jsonDecode(response.body));
  }

  Future<LoginModel> getLogin(String email, String password) async {
    String trendingpath = 'http://45.159.221.50:8868/api/signin';

    var body = {"email": email, "password": password};
    print("welcome" + body.toString());
    Response response =
        await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return LoginModel.fromJson(jsonDecode(response.body));
  }

  Future<List<NearByRentVehiclesModel>> getNearRentVehicles(
      String lat, String long) async {
    String trendingpath =
        'http://45.159.221.50:8868/api/get-nearby-vehicles?latitude=$lat&longitude=$long';

    var body = {};
    print("welcome" + body.toString());
    Response response =
        await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return NearByRentVehiclesModel.listFromJson(jsonDecode(response.body));
  }

  Future<List<AllRentVehiclesModel>> getAllRentVehicles() async {
    String trendingpath = 'http://45.159.221.50:8868/api/get-vehicles';

    var body = {};
    print("welcome" + body.toString());
    Response response =
        await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return AllRentVehiclesModel.listFromJson(jsonDecode(response.body));
  }

  Future<OrderRentVehicleModel> getOrderRentVehicles(
    String vehicleid,
    String pickeddate,
    String returneddate,
    String pickuplocationcontroller,
    String returnlocationcontroller,
    double amount,
  ) async {
    String trendingpath = 'http://45.159.221.50:8868/api/create-rent-order';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    var body = {
      "vehicle": vehicleid,
      "user": userId,
      "pickupDate": pickeddate,
      "returnDate": returneddate,
      "pickupLocation": pickuplocationcontroller,
      "returnLocation": returnlocationcontroller,
      "amount": amount
    };
    print("welcome" + body.toString());
    Response response =
        await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return OrderRentVehicleModel.fromJson(jsonDecode(response.body));
  }
}
