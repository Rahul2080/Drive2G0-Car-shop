import 'package:carousel_slider/carousel_slider.dart';
import 'package:drive2go/Bloc/AllRentVehicles_Bloc/all_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/GetAllRentVehiclesById_Bloc/get_all_rent_vehicles_by_id_bloc.dart';
import 'package:drive2go/Bloc/NearByRentVehicles_Bloc/near_by_rent_vehicles_bloc.dart';
import 'package:drive2go/Repository/ModelClass/GetAllRentVehiclesByIDModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Repository/ModelClass/AllRentVehiclesModel.dart';
import '../../Repository/ModelClass/NearByRentVehiclesModel.dart';
import 'Purchase_RentalCar.dart';

class CarRentDetails extends StatefulWidget {
  final String vehicleid;
  final String carplace;
  final List<String> recomcarplace;

  const CarRentDetails({
    super.key, required this.vehicleid, required this.carplace, required this.recomcarplace,
  });

  @override
  State<CarRentDetails> createState() => _CarRentDetailsState();
}

class _CarRentDetailsState extends State<CarRentDetails> {
  int currrentindex = 0;
  bool isfavarites = false;
  GoogleMapController? _mapController;
  Position? _currentPosition;
  LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  String? _currentAddress;
  late List<NearByRentVehiclesModel> nearrentvehicles;
  late GetAllRentVehiclesByIdModel getallrentvehiclesbyid;

  void initState() {
    _getCurrentLocation();
    BlocProvider.of<GetAllRentVehiclesByIdBloc>(context).add(
        FeatchGetAllRentVehiclesById(vehicleId: widget.vehicleid));
    super.initState();
  }

  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _initialPosition = LatLng(
          position.latitude,
          position.longitude,
        );
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(_initialPosition),
        );
      });

      await _getAddressFromLatLng(_currentPosition!).then((onValue) {
        BlocProvider.of<NearByRentVehiclesBloc>(context)
            .add(FeatchNearByCarVehicles(
          lat: position.latitude.toString(),
          long: position.longitude.toString(),
        ));
      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = " ${place.locality}, ${place.administrativeArea}";
      });

      print("Address: $_currentAddress");
    } catch (e) {
      print(e);
    }
  }


//Url Launcher
  void launchURL(Uri uri, bool inApp) async {
    try {
      if (await canLaunchUrl(uri)) {
        if (inApp) {
          await launchUrl(uri, mode: LaunchMode.inAppWebView);
        } else {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 90.w),
          child: Text(
            'Drive2Go',
            style: TextStyle(
              color: Color(0xFFF7F5F2),
              fontSize: 24.sp,
              fontFamily: 'sf pro display',
              fontWeight: FontWeight.w600,
              letterSpacing: 0.24.w,
            ),
          ),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: BlocBuilder<GetAllRentVehiclesByIdBloc,
          GetAllRentVehiclesByIdState>(
          builder: (context, state) {
            if (state is GetAllRentVehiclesByIdBlocLoading) {
              print("all car loading");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetAllRentVehiclesByIdBlocError) {
              print("all car error");
              return Center(
                child: Text(
                  "all car Error",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (state is GetAllRentVehiclesByIdBlocLoaded) {
              getallrentvehiclesbyid = BlocProvider
                  .of<GetAllRentVehiclesByIdBloc>(context)
                  .getAllRentVehiclesByIdModel;
              return Stack(
                children: [
                  SingleChildScrollView(
                    child:
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 430.w,
                          height: 313.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(8, -1.00),
                              end: Alignment(0.1, 1),
                              colors: [Colors.white, Color(0xFF000B17)],
                            ),
                          ),
                          child: CarouselSlider.builder(
                            itemCount: getallrentvehiclesbyid.photos!.length,
                            itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) =>
                                Container(
                                  width: 315.w,
                                  decoration: ShapeDecoration(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4.r),
                                    child: Image.network(
                                      getallrentvehiclesbyid.photos![index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                            options: CarouselOptions(
                                autoPlay: true,
                                enlargeCenterPage: true,
                                viewportFraction: 1,
                                initialPage: 2,
                                height: 254.h,
                                onPageChanged: (index, r) {
                                  setState(() {
                                    currrentindex = index;
                                  });
                                }),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 20.h),
                          child: SizedBox(
                            width: 200.w,
                            height: 40.h,
                            child: Text(
                              getallrentvehiclesbyid.brand.toString(),
                              style: TextStyle(
                                color: Color(0xFFF7F5F2),
                                fontSize: 20.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            widget.carplace,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 16.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Row(
                            children: [
                              RatingBar.builder(
                                itemSize: 20.sp,
                                initialRating:
                                double.parse(
                                    getallrentvehiclesbyid.rating.toString()),
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                ignoreGestures: true,
                                itemCount: 5,
                                itemPadding: EdgeInsets.symmetric(
                                    horizontal: 1.w),
                                itemBuilder: (context, _) =>
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              Text(
                                getallrentvehiclesbyid.rating.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF7F5F2),
                                  fontSize: 16.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Text(
                            getallrentvehiclesbyid.available == false
                                ? 'Notavailable'
                                : 'Available',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 20.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 20.h),
                          child: SizedBox(
                            width: 180.w,
                            height: 40.h,
                            child: Text(
                              'Car Details',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w),
                          child: Row(
                            children: [
                              Container(
                                width: 180.w,
                                height: 58.h,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(6, -1.0),
                                    end: Alignment(0.1, 1),
                                    colors: [Colors.white, Color(0xFF000B17)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.w, color: Color(0xFF58606A)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Row(
                                    children: [
                                      Icon(Icons.local_gas_station,
                                          color: Color(0xFFA7B0BB)),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6.h),
                                          Text(
                                            'Tank Type',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFA7B0BB),
                                              fontSize: 12.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            getallrentvehiclesbyid.fuelType
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.w),
                              Container(
                                width: 180.w,
                                height: 58.h,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(6, -1.0),
                                    end: Alignment(0.1, 1),
                                    colors: [Colors.white, Color(0xFF000B17)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.w, color: Color(0xFF58606A)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                          width: 25.w,
                                          height: 30.h,
                                          child: Image.asset(
                                              "assets/gear.png")),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6.h),
                                          Text(
                                            'Gearbox',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFA7B0BB),
                                              fontSize: 12.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            getallrentvehiclesbyid.gearType
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 16.w, top: 20.h),
                          child: Row(
                            children: [
                              Container(
                                width: 180.w,
                                height: 58.h,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(6, -1.0),
                                    end: Alignment(0.1, 1),
                                    colors: [Colors.white, Color(0xFF000B17)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.w, color: Color(0xFF58606A)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Row(
                                    children: [
                                      Icon(Icons.supervisor_account_outlined,
                                          color: Color(0xFFA7B0BB)),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6.h),
                                          Text(
                                            'Seats',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFA7B0BB),
                                              fontSize: 12.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            getallrentvehiclesbyid.noOfSeats
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 30.w),
                              Container(
                                width: 180.w,
                                height: 58.h,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(6, -1.0),
                                    end: Alignment(0.1, 1),
                                    colors: [Colors.white, Color(0xFF000B17)],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(
                                        width: 1.w, color: Color(0xFF58606A)),
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(left: 20.w),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 25.w,
                                        height: 30.h,
                                        child: Image.asset("assets/door.png"),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: 6.h),
                                          Text(
                                            'Door',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFA7B0BB),
                                              fontSize: 12.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            getallrentvehiclesbyid.noOfDoors
                                                .toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 20.h),
                          child: Text(
                            'Renter',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, top: 20.h),
                          child: Container(
                            width: 380.w,
                            height: 91.h,
                            decoration: ShapeDecoration(
                              color: Color(0xB21C2631),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20.w),
                              child: Row(
                                children: [
                                  Container(
                                    width: 62.w,
                                    height: 62.h,
                                    decoration: ShapeDecoration(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              7.r)),
                                    ),
                                    child: ClipRRect(
                                        borderRadius:
                                        BorderRadius.all(Radius.circular(7.r)),
                                        child: Image.network(
                                          getallrentvehiclesbyid
                                              .ownerProfilePhoto
                                              .toString(),
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                        left: 10.w, top: 17.h),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          getallrentvehiclesbyid.ownerName
                                              .toString(),
                                          style: TextStyle(
                                            color: Color(0xFFF7F5F2),
                                            fontSize: 16.sp,
                                            fontFamily: 'sf pro display',
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(height: 10.h),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.start,
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Color(0xFFF7F5F2),
                                              size: 20.sp,
                                            ),
                                            Text(
                                              getallrentvehiclesbyid.ownerPlace
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFFF7F5F2),
                                                fontSize: 14.sp,
                                                fontFamily: 'sf pro display',
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 0.50.w,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 90.w),
                                  InkWell(
                                    onTap: () =>
                                        launchURL(
                                            Uri.parse(
                                                'https://wa.me/+91 ${getallrentvehiclesbyid
                                                    .ownerPhoneNumber}'),
                                            false),
                                    child: Image.asset(
                                      'assets/whatsapp.png',
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                  InkWell(
                                    onTap: () =>
                                        launchURL(
                                            Uri.parse(
                                                'tel:${getallrentvehiclesbyid
                                                    .ownerPhoneNumber}'),
                                            false),
                                    child: Icon(
                                      Icons.wifi_calling_3_outlined,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        BlocBuilder<NearByRentVehiclesBloc,
                            NearByRentVehiclesState>(builder: (context, state) {
                          if (state is NearByRentVehiclesBlocLoading) {
                            print("loading");
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (state is NearByRentVehiclesBlocError) {
                            print("error");
                            return Center(
                              child: Text(
                                "Error",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          }
                          if (state is NearByRentVehiclesBlocLoaded) {
                            nearrentvehicles =
                                BlocProvider
                                    .of<NearByRentVehiclesBloc>(context)
                                    .nearbyrentvechicles;
                            return nearrentvehicles.length == 0
                                ? SizedBox()
                                : Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                  EdgeInsets.only(left: 20.w, top: 10.h),
                                  child: Text(
                                    'Recommended for you',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 20.w, top: 10.h),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 223.h,
                                    child: ListView.separated(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: nearrentvehicles.length,
                                      itemBuilder: (context, position) {
                                        return getallrentvehiclesbyid.id ==
                                            nearrentvehicles[position]
                                                .id
                                                .toString()
                                            ? SizedBox()
                                            : GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        CarRentDetails(
                                                          vehicleid: nearrentvehicles[position]
                                                              .id.toString(),
                                                          carplace
                                                          :widget.carplace,
                                                          recomcarplace: widget
                                                              .recomcarplace,)));
                                          },
                                          child: Container(
                                            width: 185.w,
                                            height: 223.h,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin:
                                                Alignment(8, -0.54),
                                                end: Alignment(
                                                    -0.84, 0.54),
                                                colors: [
                                                  Colors.white,
                                                  Colors.white
                                                      .withOpacity(0)
                                                ],
                                              ),
                                              shape:
                                              RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1.w,
                                                    color: Color(
                                                        0xFF58606A)),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(10.r),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .start,
                                              children: [
                                                Padding(
                                                  padding:
                                                  const EdgeInsets
                                                      .all(1),
                                                  child: Container(
                                                    width: 187.w,
                                                    height: 146.h,
                                                    decoration:
                                                    ShapeDecoration(
                                                      image:
                                                      DecorationImage(
                                                        image: NetworkImage(
                                                            nearrentvehicles[
                                                            position]
                                                                .photos![0]),
                                                        fit:
                                                        BoxFit.fill,
                                                      ),
                                                      shape:
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                        BorderRadius
                                                            .only(
                                                          topLeft: Radius
                                                              .circular(
                                                              8.r),
                                                          topRight: Radius
                                                              .circular(
                                                              8.r),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Text(
                                                    nearrentvehicles[
                                                    position]
                                                        .brand
                                                        .toString(),
                                                    textAlign: TextAlign
                                                        .center,
                                                    style: TextStyle(
                                                      color: Color(
                                                          0xFFF7F5F2),
                                                      fontSize: 16.sp,
                                                      fontFamily:
                                                      'sf pro display',
                                                      fontWeight:
                                                      FontWeight
                                                          .w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                  EdgeInsets.only(
                                                      left: 5.w),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color: Color(
                                                            0xFFF7F5F2),
                                                        size: 18.sp,
                                                      ),
                                                      SizedBox(
                                                        width: 90.w,
                                                        height: 20.h,
                                                        child: Text(
                                                          widget
                                                              .recomcarplace[position],
                                                          textAlign:
                                                          TextAlign
                                                              .start,
                                                          style:
                                                          TextStyle(
                                                            color: Color(
                                                                0xFFF7F5F2),
                                                            fontSize:
                                                            13.sp,
                                                            fontFamily:
                                                            'sf pro display',
                                                            fontWeight:
                                                            FontWeight
                                                                .w300,
                                                            letterSpacing:
                                                            0.50.w,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "\₹ ${nearrentvehicles[position]
                                                            .rentPrice
                                                            .toString()} ",
                                                        textAlign:
                                                        TextAlign
                                                            .center,
                                                        style:
                                                        TextStyle(
                                                          color: Color(
                                                              0xFFFFD66D),
                                                          fontSize:
                                                          13.sp,
                                                          fontFamily:
                                                          'SF Pro Display',
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          letterSpacing:
                                                          0.50.w,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, position) {
                                        return SizedBox(
                                          width: 10.w,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return SizedBox();
                          }
                        }),
                        SizedBox(height: 90.h),
                      ],
                    ),
                  ),
                  getallrentvehiclesbyid.available == true
                      ? Padding(
                    padding: EdgeInsets.only(top: 750.h),
                    child: Container(
                      width: 430.w,
                      height: 99.h,
                      decoration: ShapeDecoration(
                        color: Colors.white.withOpacity(0.7344567788),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(16.r),
                            topRight: Radius.circular(16.r),
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 20.w),
                        child: Row(
                          children: [
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: ' \₹ {widget.carprice}',
                                    style: TextStyle(
                                      color: Color(0xFF000B17),
                                      fontSize: 20.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '/Day',
                                    style: TextStyle(
                                      color: Color(0xFF000B17),
                                      fontSize: 15.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 70.w),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) =>
                                        PurchaseRentalcar(
                                          carname: ' widget.carname',
                                          carcolor: ' widget.carcolor',
                                          price: 'widget.carprice',
                                          carimage: 'widget.carimage[0]',
                                          vehicleid: 'widget.vehicleid',
                                        )));
                              },
                              child: Container(
                                width: 213.w,
                                height: 50.h,
                                decoration: ShapeDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color(0xFFFFF0C9),
                                      Color(0xFFFFCE50),
                                      Color(0xFFD39906),
                                    ],
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.r),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    'Rent Now',
                                    style: TextStyle(
                                      color: Color(0xFFF7F5F2),
                                      fontSize: 20.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                      : SizedBox(),
                ],
              );
            } else {
              return SizedBox();
            }
          }
      ),
    );
  }
}
