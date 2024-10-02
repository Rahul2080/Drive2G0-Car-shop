import 'dart:convert';
import 'dart:core';
import 'dart:io';

import 'package:drive2go/Repository/ModelClass/AuthenticationModels/LoginModel.dart';
import 'package:drive2go/Repository/ModelClass/RentVehiclesModels/NearByRentVehiclesModel.dart';
import 'package:drive2go/main.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ModelClass/AuthenticationModels/ForgotPasswordModel.dart';
import '../ModelClass/RentVehiclesModels/AllRentVehiclesModel.dart';
import '../ModelClass/BuyvehiclesModels/BuyAllVehiclesModel.dart';
import '../ModelClass/BuyvehiclesModels/BuyNearVehiclesModel.dart';
import '../ModelClass/ProfileModels/EditProfileModel.dart';
import '../ModelClass/ProfileModels/FeedbackModel/FeedbackModel.dart';
import '../ModelClass/RentVehiclesModels/GetAllRentVehiclesByIDModel.dart';
import '../ModelClass/BuyvehiclesModels/MyOrderBuyVehiclesModel.dart';
import '../ModelClass/NotificationModels/NotificationMarkReadModel.dart';
import '../ModelClass/NotificationModels/NotificationByUserIDModel.dart';
import '../ModelClass/BuyvehiclesModels/OrderBuyVehiclesModel.dart';
import '../ModelClass/RentVehiclesModels/MyRentVehiclesModel.dart';
import '../ModelClass/RentVehiclesModels/OrderRentVehicleModel.dart';
import '../ModelClass/ProfileModels/ProfileModel.dart';
import '../ModelClass/SearchvehiclesModels/SearchBuyVehiclesModel.dart';
import '../ModelClass/SearchvehiclesModels/SearchRentVehiclesModel.dart';
import '../ModelClass/ProfileModels/HelpChatModels/SendMessageModel.dart';
import '../ModelClass/ProfileModels/HelpChatModels/ShowSendMessageModel.dart';
import '../ModelClass/AuthenticationModels/UserModel.dart';
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
  Future<LoginModel> getLogin(String email, String password , String fcmToken) async {
    String trendingpath = 'http://45.159.221.50:8868/api/signin';

    var body = {
      "email": email,
      "password": password,
      "fcmToken": fcmToken
    };
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
  //Get All Rent Vehicles By Id
  Future<GetAllRentVehiclesByIdModel> getGetAllRentVehiclesById(String vehicleId ) async {
    String trendingpath = 'http://45.159.221.50:8868/api/get-vehicle/$vehicleId';

    var body = {

    };
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return GetAllRentVehiclesByIdModel.fromJson(jsonDecode(response.body));
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



//Edit Profile for name and password
  Future<EditProfileModel> getMyEditProfile(String name,String oldpassword,String newpassword) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    String trendingpath = 'http://45.159.221.50:8868/api/update-profile/$userId';

    var body = {
      "fullName": name,
      "oldPassword":oldpassword,
      "newPassword":newpassword,
    }
    ;
    print("welcome" + body.toString());
      Response response =
      await apiClient.invokeAPI(trendingpath, 'PUT', jsonEncode(body));
    return EditProfileModel.fromJson(jsonDecode(response.body));
  }


// Edit profile for profile photo

  Future<EditProfileModel> getMyEditProfilePhoto(String name, String email, String oldPassword, String newPassword, File profileUrl) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    String updateProfileUrl = 'http://45.159.221.50:8868/api/update-profile/$userId';

    // Using multipart request for uploading image
    var request = http.MultipartRequest('PUT', Uri.parse(updateProfileUrl));

    // Adding other fields to the request
    request.fields['fullName'] = name;
    request.fields['email'] = email;
    request.fields['oldPassword'] = oldPassword;
    request.fields['newPassword'] = newPassword;

    // Adding the profile picture as a multipart file
    if (profileUrl != null) {
      request.files.add(await http.MultipartFile.fromPath('profilePhoto', profileUrl.path));
    }

    // Sending the request
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 200) {
      // Parsing the response body to EditProfileModel
      return EditProfileModel.fromJson(jsonDecode(response.body));
    } else {
      // Handle errors accordingly
      throw Exception('Failed to update profile: ${response.body}');
    }
  }



// Profile


  Future<ProfileModel> getMyProfile( ) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    String trendingpath = 'http://45.159.221.50:8868/api/user/$userId';

    var body = {};
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return ProfileModel.fromJson(jsonDecode(response.body));
  }



//Feedback
  Future<FeedbackModel> getMyFeedback(String comments ) async {

    String trendingpath = 'http://45.159.221.50:8868/api/feedback';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    var body = {
      "user": userId,
      "comments":comments ,
    };
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return FeedbackModel.fromJson(jsonDecode(response.body));
  }

  //SendMessage

  Future<SendMessageModel> getMySendMessage(String Description ) async {

    String trendingpath = 'http://45.159.221.50:8868/api/help-center';
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();

    var body = {
      "user": userId,
      "queryDescription": Description
    }
    ;
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return SendMessageModel.fromJson(jsonDecode(response.body));
  }

// Show Send Meassage

  Future <List<ShowSendMessageModel>> getShowSendMessage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    String trendingpath = 'http://45.159.221.50:8868/api/help-center/user/$userId';


    var body = {};
    print("welcome" + userId.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return ShowSendMessageModel.listFromJson(jsonDecode(response.body));
  }

  // Notification By User Id
  Future <List<NotificationByUserIdModel>> getNotificationByUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userId').toString();
    String trendingpath = 'http://45.159.221.50:8868/api/notifications/user/$userId';


    var body = {};
    print("welcome" + userId.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'GET', jsonEncode(body));

    return NotificationByUserIdModel.listFromJson(jsonDecode(response.body));
  }

  Future<NotificationMarkReadModel> getMyReadMessage(String id ) async {

    String trendingpath = 'http://45.159.221.50:8868/api/notifications/$id/read';

    var body = {};
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'PUT', jsonEncode(body));

    return NotificationMarkReadModel.fromJson(jsonDecode(response.body));
  }


  Future<ForgotPasswordModel> getForgotPasswod( String userId) async {

    String trendingpath = 'http://45.159.221.50:8868/api/forgot-password';
    var body = {
      "email": userId
    };
    print("welcome" + body.toString());
    Response response =
    await apiClient.invokeAPI(trendingpath, 'POST', jsonEncode(body));

    return ForgotPasswordModel.fromJson(jsonDecode(response.body));
  }

}
