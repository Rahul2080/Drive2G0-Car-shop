import 'package:carousel_slider/carousel_slider.dart';
import 'package:drive2go/Bloc/NearByRentVehicles_Bloc/near_by_rent_vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Repository/ModelClass/NearByRentVehiclesModel.dart';
import 'Purchase_RentalCar.dart';

class CarRentDetails extends StatefulWidget {
  final List<String> carimage;
  final List<String> carplace;
  final String carname;
  final String rating;
  final String greartype;
  final String tanktype;
  final String seats;
  final String door;
  final String carowner;
  final String ownerplace;
  final String carprice;
  final String carcolor;
  final bool availability;
  final String vehicleid;
  final String ownerprofileimg;
  final String place;
  final String ownernumber;


  const CarRentDetails(
      {super.key,
      required this.carimage,
      required this.carname,
      required this.rating,
      required this.greartype,
      required this.tanktype,
      required this.seats,
      required this.door,
      required this.carowner,
      required this.ownerplace,
      required this.carprice,
      required this.carcolor,
      required this.availability,
      required this.vehicleid,
      required this.ownerprofileimg, required this.carplace, required this.place, required this.ownernumber,

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
  void initState() {
    _getCurrentLocation();

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
            widget.carname.toString(),
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
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
                    itemCount: widget.carimage.length,
                    itemBuilder:
                        (BuildContext context, int index, int pageViewIndex) =>
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
                          widget.carimage[index],
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
                  child: Row(
                    children: [
                      SizedBox(
                        width: 200.w,
                        height: 40.h,
                        child: Text(
                          widget.carname,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 20.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      SizedBox(width: 140.w),
                      SizedBox(
                          width: 50.w,
                          height: 40.h,
                          child: IconButton(
                            icon: isfavarites == true
                                ? Icon(
                                    Icons.favorite,
                                    size: 30.sp,
                                    color: Colors.red,
                                  )
                                : Icon(
                                    Icons.favorite_border,
                                    size: 30.sp,
                                  ),
                            onPressed: () {
                              setState(() {
                                isfavarites = !isfavarites;
                              });
                            },
                          )),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 20.w),
                  child: Text(
                   widget.place ,
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
                        initialRating: double.parse(widget.rating),
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        ignoreGestures: true,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 1.w),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                      Text(
                        " ${widget.rating} ",
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
                    widget.availability == false ? 'Notavailable' : 'Available',
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    widget.tanktype,
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
                                  child: Image.asset("assets/gear.png")),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    widget.greartype,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    widget.seats,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                    widget.door,
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
                                  borderRadius: BorderRadius.circular(7.r)),
                            ),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.r)),
                                child: Image.network(
                                  widget.ownerprofileimg,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w, top: 17.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.carowner,
                                  style: TextStyle(
                                    color: Color(0xFFF7F5F2),
                                    fontSize: 16.sp,
                                    fontFamily: 'sf pro display',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      color: Color(0xFFF7F5F2),
                                      size: 20.sp,
                                    ),
                                    Text(
                                      widget.ownerplace,
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
                      InkWell(onTap: () => launchURL(Uri.parse('https://wa.me/+91 ${widget.ownernumber}') ,false),
                        child: Image.asset(
                          'assets/whatsapp.png',
                          width: 30.w,
                          height: 30.h,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      InkWell(onTap:() => launchURL(Uri.parse('tel:${widget.ownernumber}'), false),
                        child: Icon(
                          Icons.wifi_calling_3_outlined,
                          color: Colors.white,
                        ),),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
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
                  padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                  child: SizedBox(
                    width: double.infinity,
                    height: 223.h,
                    child: BlocBuilder<NearByRentVehiclesBloc,
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
                            BlocProvider.of<NearByRentVehiclesBloc>(context)
                                .nearbyrentvechicles;
                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: nearrentvehicles.length,
                          itemBuilder: (context, position) {
                            return widget.vehicleid ==
                                    nearrentvehicles[position].id.toString()
                                ? SizedBox()
                                :
                                       GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder:
                                                        (_) => CarRentDetails(
                                                              carimage:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .photos!
                                                                      .toList(),
                                                              carname: nearrentvehicles[
                                                                      position]
                                                                  .brand
                                                                  .toString(),
                                                              rating: nearrentvehicles[
                                                                      position]
                                                                  .rating
                                                                  .toString(),
                                                              greartype:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .gearType
                                                                      .toString(),
                                                              tanktype:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .fuelType
                                                                      .toString(),
                                                              seats: nearrentvehicles[
                                                                      position]
                                                                  .noOfSeats
                                                                  .toString(),
                                                              door: nearrentvehicles[
                                                                      position]
                                                                  .noOfDoors
                                                                  .toString(),
                                                              carowner:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .ownerName
                                                                      .toString(),
                                                              ownerplace:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .ownerPlace
                                                                      .toString(),
                                                              carprice:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .rentPrice
                                                                      .toString(),
                                                              carcolor: nearrentvehicles[
                                                                      position]
                                                                  .vehicleColor
                                                                  .toString(),
                                                              availability:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .available!,
                                                              vehicleid:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .id
                                                                      .toString(),
                                                              ownerprofileimg:
                                                                  nearrentvehicles[
                                                                          position]
                                                                      .ownerProfilePhoto
                                                                      .toString(), carplace: widget.carplace, place: widget.place, ownernumber: nearrentvehicles[position].ownerPhoneNumber.toString(),
                                                            )));
                                          },
                                          child: Container(
                                            width: 185.w,
                                            height: 223.h,
                                            decoration: ShapeDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment(8, -0.54),
                                                end: Alignment(-0.84, 0.54),
                                                colors: [
                                                  Colors.white,
                                                  Colors.white.withOpacity(0)
                                                ],
                                              ),
                                              shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    width: 1.w,
                                                    color: Color(0xFF58606A)),
                                                borderRadius:
                                                    BorderRadius.circular(10.r),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(1),
                                                  child: Container(
                                                    width: 187.w,
                                                    height: 146.h,
                                                    decoration: ShapeDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            nearrentvehicles[position]
                                                                .photos![0]),
                                                        fit: BoxFit.fill,
                                                      ),
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  8.r),
                                                          topRight:
                                                              Radius.circular(
                                                                  8.r),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 15.h),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10.w),
                                                  child: Text(
                                                    nearrentvehicles[position]
                                                        .brand
                                                        .toString(),
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFFF7F5F2),
                                                      fontSize: 16.sp,
                                                      fontFamily:
                                                          'sf pro display',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 5.w),
                                                  child: Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color:
                                                            Color(0xFFF7F5F2),
                                                        size: 18.sp,
                                                      ),
                                                      SizedBox(width: 90.w,height: 20.h,
                                                        child: Text(
                                                          widget.carplace[position],
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                            color:
                                                                Color(0xFFF7F5F2),
                                                            fontSize: 13.sp,
                                                            fontFamily:
                                                                'sf pro display',
                                                            fontWeight:
                                                                FontWeight.w300,
                                                            letterSpacing: 0.50.w,
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        "\₹ ${nearrentvehicles[position].rentPrice.toString()} ",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color:
                                                              Color(0xFFFFD66D),
                                                          fontSize: 13.sp,
                                                          fontFamily:
                                                              'SF Pro Display',
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          letterSpacing: 0.50.w,
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
                        );
                      } else {
                        return SizedBox();
                      }
                    }),
                  ),
                ),
                SizedBox(height: 90.h),
              ],
            ),
          ),
          widget.availability == true
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
                                  text: ' \₹ ${widget.carprice}',
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
                                  builder: (_) => PurchaseRentalcar(
                                        carname: widget.carname,
                                        carcolor: widget.carcolor,
                                        price: widget.carprice,
                                        carimage: widget.carimage[0],
                                        vehicleid: widget.vehicleid,
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
      ),
    );
  }
}
