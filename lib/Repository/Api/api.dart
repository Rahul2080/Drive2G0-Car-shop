import 'dart:convert';

import 'package:drive2go/Repository/ModelClass/LoginModel.dart';
import 'package:drive2go/Repository/ModelClass/NearByRentVehiclesModel.dart';
import 'package:drive2go/main.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClass/AllRentVehiclesModel.dart';
import '../ModelClass/BuyAllVehiclesModel.dart';
import '../ModelClass/BuyNearVehiclesModel.dart';
import '../ModelClass/MyOrderBuyVehiclesModel.dart';
import '../ModelClass/OrderBuyVehiclesModel.dart';
import '../ModelClass/MyRentVehiclesModel.dart';
import '../ModelClass/OrderRentVehicleModel.dart';
import '../ModelClass/ProfileModel.dart';
import '../ModelClass/SearchBuyVehiclesModel.dart';
import '../ModelClass/SearchRentVehiclesModel.dart';
import '../ModelClass/UserModel.dart';
import 'Api_client.dart';

class UserApi {
  ApiClient apiClient = ApiClient();
//Siginup
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
//Login
  Future<LoginModel> getLogin(String email, String password) async {
    String trendingpath = 'http://45.159.221.50:8868/api/signin';

    var body = {"email": email, "password": password};
    print("welcome" + body.toString());
    Response response =
        await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return LoginModel.fromJson(jsonDecode(response.body));
  }
//NearByRentVehicles
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
//AllRentVehicles
  Future<List<AllRentVehiclesModel>> getAllRentVehicles() async {
    String trendingpath = 'http://45.159.221.50:8868/api/get-vehicles';

    var body = {};
    print("welcome" + body.toString());
    Response response =
        await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return AllRentVehiclesModel.listFromJson(jsonDecode(response.body));
  }
//OrderRentVehicles
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

//Show Purchased RentVehicles
  Future<List<MyRentVehiclesModel>> getMyRentVehicles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    String trendingpath = 'http://45.159.221.50:8868/api/get-rent-orders/$userId';


    var body = {};
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return MyRentVehiclesModel.listFromJson(jsonDecode(response.body));
  }

  //Search Rent Vehicles
  Future<List<SearchRentVehiclesModel>> getSearchRentVehicles( String brandname) async {
    String trendingpath = 'http://45.159.221.50:8868/api/search-vehicles?brand=$brandname';

    var body = {

    };
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return SearchRentVehiclesModel.listFromJson(jsonDecode(response.body));
  }

//Buy NearVehicles
  Future<List<BuyNearVehiclesModel>> getBuyNearVehicles(
      String lat, String long) async {
    String trendingpath =
        'http://45.159.221.50:8868/api/get-nearby-buyvehicles?latitude=$lat&longitude=$long';

    var body = {};
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return BuyNearVehiclesModel.listFromJson(jsonDecode(response.body));
  }
//Buy All Vehicles
  Future<List<BuyAllVehiclesModel>> getBuyAllVehicles() async {
    String trendingpath = 'http://45.159.221.50:8868/api/get-buyvehicles';

    var body = {};
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return BuyAllVehiclesModel.listFromJson(jsonDecode(response.body));
  }

// Buy Vehicles
  Future<OrderBuyVehiclesModel> getOrderBuyVehicles(
      String vehicleid,
      String buyername,
      String buyerphonenumber,
      String buyeremail,
      String buyeraddress,
      double amount,
      ) async {
    String trendingpath = 'http://45.159.221.50:8868/api/create-buy-order';

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    var body = {
      "vehicle": vehicleid,
      "buyerId": userId,
      "buyerName": buyername,
      "buyerPhoneNumber": buyerphonenumber,
      "buyerEmail":buyeremail,
      "buyerAddress": buyeraddress,
      "purchasePrice": amount
    };
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return OrderBuyVehiclesModel.fromJson(jsonDecode(response.body));
  }

  // Search Buy Vehicles

  Future<List<SearchBuyVehiclesModel>> getSearchBuyVehicles( String brandname) async {
    String trendingpath = 'http://45.159.221.50:8868/api/search-buyvehicles?brand=$brandname';

    var body = {

    };
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return SearchBuyVehiclesModel.listFromJson(jsonDecode(response.body));
  }
  // My ordered Buy Vehicles
  Future<List<MyOrderBuyVehiclesModel>> getMyOrderBuyVehicles() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    String trendingpath = 'http://45.159.221.50:8868/api/get-buy-orders/$userId';


    var body = {};
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return MyOrderBuyVehiclesModel.listFromJson(jsonDecode(response.body));
  }

  // Profile
  Future<ProfileModel> getMyProfile() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    String trendingpath = 'http://45.159.221.50:8868/api/update-profile/$userId';


    var body = {


    };
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'PUT', jsonEncode(body));

    return ProfileModel.fromJson(jsonDecode(response.body));
  }


}
