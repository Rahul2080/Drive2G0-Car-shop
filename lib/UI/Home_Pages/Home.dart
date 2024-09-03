import 'package:drive2go/Bloc/AllRentVehicles_Bloc/all_rent_vehicles_bloc.dart';
import 'package:drive2go/Bloc/NearByRentVehicles_Bloc/near_by_rent_vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Repository/ModelClass/AllRentVehiclesModel.dart';
import '../../Repository/ModelClass/NearByRentVehiclesModel.dart';
import 'Rent_Car_Search.dart';
import 'car_Rent_details.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? _mapController;
  Position? _currentPosition;
  LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  String? _currentAddress;

  @override
  void initState() {
    _requestPermission();
    _getCurrentLocation();
    BlocProvider.of<AllRentVehiclesBloc>(context).add(FeatchAllRentVehicles());

    super.initState();
  }

  Future<void> _requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Handle permission denied
        return;
      }
    } else if (permission == LocationPermission.deniedForever) {
      // Handle permission denied forever
      return;
    }
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

  Future<List<Placemark>> _getVechileAddress(String lat, String long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lat),
        double.parse(long),
      );

      return placemarks; // Return the list of placemarks instead of a single placemark
    } catch (e) {
      print(e);
      return []; // Return an empty list in case of an error
    }
  }

  late List<NearByRentVehiclesModel> nearrentvehicles;
  late List<AllRentVehiclesModel> allrentvechicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    SizedBox(
                      width: 219.w,
                      height: 65.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: Text(
                              'location ',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color(0xFFF7F5F2),
                                fontSize: 20.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            '$_currentAddress',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 20.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 138.w),
                    Container(
                      width: 45.w,
                      height: 45.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFF7F5F2),
                        shape: OvalBorder(),
                      ),
                      child: Icon(Icons.notifications_none_outlined),
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => RentCarSearch()));
                },
                child: Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    children: [
                      Container(
                        width: 292.w,
                        height: 48.h,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(5, -0.54),
                            end: Alignment(-0.34, 0.54),
                            colors: [Colors.white, Colors.white.withOpacity(0)],
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: Color(0xFF58606A)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.w),
                          child: Row(
                            children: [
                              Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                'Search your dream car..',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF627387),
                                  fontSize: 15.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w300,
                                  letterSpacing: 1.50.w,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 60.w),
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFFCE50),
                          shape: OvalBorder(),
                        ),
                        child: Icon(
                          Icons.tune,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 100.w,
                      height: 40.h,
                      child: Text(
                        'Nearby',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 22.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 240.w),
                    SizedBox(
                      width: 90.w,
                      height: 40.h,
                      child: Text(
                        'View all',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 10.w),
                child: SizedBox(
                  width: double.infinity,
                  height: 233.h,
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
                      print("loaded");
                      return ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: nearrentvehicles.length,
                        itemBuilder: (context, position) {
                          return FutureBuilder<List<Placemark>>(
                              future: _getVechileAddress(
                                  nearrentvehicles[position]
                                      .location!
                                      .coordinates!
                                      .first
                                      .toString(),
                                  nearrentvehicles[position]
                                      .location!
                                      .coordinates!
                                      .last
                                      .toString()),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text("Error fetching location"));
                                } else if (snapshot.hasData) {
                                  String? place = snapshot.data![0].locality;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (_) => CarRentDetails(
                                                    carimage: nearrentvehicles[
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
                                                    greartype: nearrentvehicles[
                                                            position]
                                                        .gearType
                                                        .toString(),
                                                    tanktype: nearrentvehicles[
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
                                                    carowner: nearrentvehicles[
                                                            position]
                                                        .ownerName
                                                        .toString(),
                                                    ownerplace:
                                                        nearrentvehicles[
                                                                position]
                                                            .ownerPlace
                                                            .toString(),
                                                    carprice: nearrentvehicles[
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
                                                    id: nearrentvehicles[
                                                            position]
                                                        .id
                                                        .toString(),
                                                    vehicleid: nearrentvehicles[
                                                            position]
                                                        .id
                                                        .toString(), ownerprofileimg: nearrentvehicles[position].ownerProfilePhoto.toString()
                                                  )));
                                    },
                                    child: Container(
                                      width: 185.w,
                                      height: 223.h,
                                      decoration: ShapeDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment(4, -0.54),
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
                                            padding: const EdgeInsets.all(1),
                                            child: Container(
                                              width: 187.w,
                                              height: 146.h,
                                              decoration: ShapeDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      nearrentvehicles[position]
                                                          .photos![0]
                                                          .toString()),
                                                  fit: BoxFit.fill,
                                                ),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(8.r),
                                                    topRight:
                                                        Radius.circular(8.r),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                left: 10.w, top: 10.h),
                                            child: Text(
                                              nearrentvehicles[position]
                                                  .brand
                                                  .toString(),
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFFF7F5F2),
                                                fontSize: 16.sp,
                                                fontFamily: 'sf pro display',
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.only(left: 5.w),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  color: Color(0xFFF7F5F2),
                                                  size: 20.sp,
                                                ),
                                                Text(
                                                  place!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFF7F5F2),
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        'sf pro display',
                                                    fontWeight: FontWeight.w300,
                                                    letterSpacing: 0.50.w,
                                                  ),
                                                ),
                                                SizedBox(width: 20.w),
                                                Text(
                                                  "  \₹ ${nearrentvehicles[position].rentPrice.toString()}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFFD66D),
                                                    fontSize: 13.sp,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.50.w,
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsets.only(left: 10.w),
                                            child: Text(
                                              nearrentvehicles[position]
                                                          .available ==
                                                      false
                                                  ? 'Notavialable'
                                                  : 'Available',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: Color(0xFFF7F5F2),
                                                fontSize: 14.sp,
                                                fontFamily: 'sf pro display',
                                                fontWeight: FontWeight.w300,
                                                letterSpacing: 0.50.w,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox();
                                }
                                ;
                              });
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
              Padding(
                padding: EdgeInsets.only(left: 10.w, top: 15.h),
                child: Row(
                  children: [
                    SizedBox(
                      width: 150.w,
                      height: 40.h,
                      child: Text(
                        'All Cars',
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 22.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(width: 170.w),
                    SizedBox(
                      width: 100.w,
                      height: 30.h,
                      child: Text(
                        'View all',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: SizedBox(
                  width: 410.w,
                  height: 580.h,
                  child: BlocBuilder<AllRentVehiclesBloc, AllRentVehiclesState>(
                      builder: (context, state) {
                    if (state is AllRentVehiclesBlocLoading) {
                      print("all car loading");
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is AllRentVehiclesBlocError) {
                      print("all car error");
                      return Center(
                        child: Text(
                          "all car Error",
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    if (state is AllRentVehiclesBlocLoaded) {
                      allrentvechicle =
                          BlocProvider.of<AllRentVehiclesBloc>(context)
                              .allrentvehicles;
                      return GridView.count(
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 185 / 233,
                        children: List.generate(
                          allrentvechicle.length,
                          (index) {
                            return FutureBuilder<List<Placemark>>(
                                future: _getVechileAddress(
                                    allrentvechicle[index]
                                        .location!
                                        .coordinates!
                                        .first
                                        .toString(),
                                    allrentvechicle[index]
                                        .location!
                                        .coordinates!
                                        .last
                                        .toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child: Text("Error fetching location"));
                                  } else if (snapshot.hasData) {
                                    String? place = snapshot.data![0].locality;
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) =>
                                                      CarRentDetails(
                                                        carimage:
                                                            allrentvechicle[
                                                                    index]
                                                                .photos!,
                                                        carname:
                                                            allrentvechicle[
                                                                    index]
                                                                .brand
                                                                .toString(),
                                                        rating: allrentvechicle[
                                                                index]
                                                            .rating
                                                            .toString(),
                                                        greartype:
                                                            allrentvechicle[
                                                                    index]
                                                                .gearType
                                                                .toString(),
                                                        tanktype:
                                                            allrentvechicle[
                                                                    index]
                                                                .fuelType
                                                                .toString(),
                                                        seats: allrentvechicle[
                                                                index]
                                                            .noOfSeats
                                                            .toString(),
                                                        door: allrentvechicle[
                                                                index]
                                                            .noOfDoors
                                                            .toString(),
                                                        carowner:
                                                            allrentvechicle[
                                                                    index]
                                                                .ownerName
                                                                .toString(),
                                                        ownerplace:
                                                            allrentvechicle[
                                                                    index]
                                                                .ownerPlace
                                                                .toString(),
                                                        carprice:
                                                            allrentvechicle[
                                                                    index]
                                                                .rentPrice
                                                                .toString(),
                                                        carcolor:
                                                            allrentvechicle[
                                                                    index]
                                                                .vehicleColor
                                                                .toString(),
                                                        availability:
                                                            allrentvechicle[
                                                                    index]
                                                                .available!,
                                                        id: allrentvechicle[
                                                                index]
                                                            .id
                                                            .toString(),
                                                        vehicleid:
                                                            allrentvechicle[
                                                                    index]
                                                                .id
                                                                .toString(),
                                                        ownerprofileimg: allrentvechicle[index].ownerProfilePhoto.toString(),
                                                      )));
                                        },
                                        child: Container(
                                          width: 185.w,
                                          height: 223.h,
                                          decoration: ShapeDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment(4, -0.54),
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
                                                  width: 197.w,
                                                  height: 146.h,
                                                  decoration: ShapeDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          allrentvechicle[index]
                                                              .photos![0]
                                                              .toString()),
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
                                              SizedBox(height: 10.h),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 10.w),
                                                child: Text(
                                                  allrentvechicle[index]
                                                      .brand
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFF7F5F2),
                                                    fontSize: 16.sp,
                                                    fontFamily:
                                                        'sf pro display',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    EdgeInsets.only(left: 5.w),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Color(0xFFF7F5F2),
                                                      size: 20.sp,
                                                    ),
                                                    Text(
                                                      place!,
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFFF7F5F2),
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                            'sf pro display',
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        letterSpacing: 0.50.w,
                                                      ),
                                                    ),
                                                    SizedBox(width: 20.w),
                                                    Text(
                                                      ' \₹ ${allrentvechicle[index].rentPrice.toString()}',
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
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.w, top: 2.h),
                                                child: Text(
                                                  allrentvechicle[index]
                                                              .available ==
                                                          false
                                                      ? 'Notavialable'
                                                      : 'Available',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFF7F5F2),
                                                    fontSize: 14.sp,
                                                    fontFamily:
                                                        'sf pro display',
                                                    fontWeight: FontWeight.w300,
                                                    letterSpacing: 0.50.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                });
                          },
                        ),
                      );
                    } else {
                      return SizedBox();
                    }
                  }),
                ),
              )
            ],
          ),
        ));
  }
}
