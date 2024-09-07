import 'package:drive2go/Bloc/BuyAllVehicles_Bloc/buy_all_vehicles_bloc.dart';
import 'package:drive2go/Bloc/BuyNearVehicles_Bloc/buy_near_vehicles_bloc.dart';
import 'package:drive2go/Repository/ModelClass/BuyAllVehiclesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Repository/ModelClass/BuyNearVehiclesModel.dart';
import 'Buy_Car_Search.dart';
import 'CarBuy_Details.dart';

class Buycar extends StatefulWidget {
  const Buycar({super.key});

  @override
  State<Buycar> createState() => _BuycarState();
}

class _BuycarState extends State<Buycar> {
  late List<BuyNearVehiclesModel> buynearvehicle;
  late List<BuyAllVehiclesModel> buyallvehicle;
  GoogleMapController? _mapController;
  String? _currentAddress;
  Position? _currentPosition;
  LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
List<String>places=[];
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
        BlocProvider.of<BuyNearVehiclesBloc>(context).add(FeatchBuyNearVehicles(
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

  void initState() {
    _getCurrentLocation();
    BlocProvider.of<BuyAllVehiclesBloc>(context).add(FeatchBuyAllVehicle());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: BlocBuilder<BuyAllVehiclesBloc, BuyAllVehiclesState>(
            builder: (context, state) {
          if (state is BuyAllVehiclesBlocLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is BuyAllVehiclesBlocError) {
            return Center(
              child: Text(
                "Error",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          if (state is BuyAllVehiclesBlocLoaded) {
            buyallvehicle =
                BlocProvider.of<BuyAllVehiclesBloc>(context).buyallvehicles;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 10.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => BuyCarSearch()));
                        },
                        child: Container(
                          width: 292.w,
                          height: 48.h,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(5, -0.54),
                              end: Alignment(-0.34, 0.54),
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0)
                              ],
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
                      ),
                      SizedBox(width: 10.w),
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
                      SizedBox(width: 10.w),
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
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 40.h,
                        child: Text(
                          'Nearby ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 22.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 180.w),
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
                    height: 223.h,
                    child:
                        BlocBuilder<BuyNearVehiclesBloc, BuyNearVehiclesState>(
                            builder: (context, state) {
                      if (state is BuyNearVehiclesBlocLoading) {
                        return Center(child: CircularProgressIndicator());
                      }

                      if (state is BuyNearVehiclesBlocError) {
                        return Center(
                          child: Text(
                            "Error",
                            style: TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (state is BuyNearVehiclesBlocLoaded) {
                        buynearvehicle =
                            BlocProvider.of<BuyNearVehiclesBloc>(context)
                                .buynearvehicles;

                        return ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: buynearvehicle.length,
                          itemBuilder: (context, position) {
                            return FutureBuilder<List<Placemark>>(
                                future: _getVechileAddress(
                                    buynearvehicle[position]
                                        .location!
                                        .coordinates!
                                        .first
                                        .toString(),
                                    buynearvehicle[position]
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
places.add(place??"");
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.of(context)
                                            .push(MaterialPageRoute(
                                                builder: (_) => CarbuyDetails(
                                                      carimage: buynearvehicle[
                                                              position]
                                                          .photos!
                                                          .toList(),
                                                      carname: buynearvehicle[
                                                              position]
                                                          .brand
                                                          .toString(),
                                                      ratting: buynearvehicle[
                                                              position]
                                                          .rating
                                                          .toString(),
                                                      tanktype: buynearvehicle[
                                                              position]
                                                          .fuelType
                                                          .toString(),
                                                      geartype: buynearvehicle[
                                                              position]
                                                          .gearType
                                                          .toString(),
                                                      seat: buynearvehicle[
                                                              position]
                                                          .noOfSeats
                                                          .toString(),
                                                      door: buynearvehicle[
                                                              position]
                                                          .noOfDoors
                                                          .toString(),
                                                  price: buynearvehicle[position].rentPrice.toString(),
                                                      Ownerimge: buynearvehicle[
                                                              position]
                                                          .ownerProfilePhoto
                                                          .toString(),
                                                      Ownername: buynearvehicle[
                                                              position]
                                                          .ownerName
                                                          .toString(),
                                                      Ownerplace:
                                                          buynearvehicle[
                                                                  position]
                                                              .ownerPlace
                                                              .toString(),
                                                  id: buynearvehicle[position].id.toString(),
                                                  carplace: place, places: places,
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
                                                        buynearvehicle[position]
                                                            .photos![0]),
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
                                            SizedBox(height: 15.h),
                                            Padding(
                                              padding:
                                                  EdgeInsets.only(left: 10.w),
                                              child: Text(
                                                buynearvehicle[position]
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
                                              padding:
                                                  EdgeInsets.only(left: 5.w),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    color: Color(0xFFF7F5F2),
                                                    size: 20.sp,
                                                  ),
                                                  SizedBox(
                                                    width: 80.w,
                                                    child: Text(
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
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Text(
                                                    "  \₹ ${buynearvehicle[position].rentPrice.toString()}",
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFFFFD66D),
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
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
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
buyallvehicle.length==0 ?SizedBox():
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 15.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 40.h,
                        child: Text(
                          'latest Model',
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
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 223.h,
                    child: ListView.separated(
                      itemCount: buyallvehicle.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {

                        return  buyallvehicle[position].latestModel==true?  FutureBuilder(
                            future: _getVechileAddress(
                                buyallvehicle[position]
                                    .location!
                                    .coordinates!
                                    .first
                                    .toString(),
                                buyallvehicle[position]
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
                                return
                                  GestureDetector(onTap: (){
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (_) => CarbuyDetails(
                                        carimage:
                                        buyallvehicle[position]
                                            .photos!
                                            .toList(),
                                        carname:
                                        buyallvehicle[position]
                                            .brand
                                            .toString(),
                                        ratting:
                                        buyallvehicle[position]
                                            .rating
                                            .toString(),
                                        tanktype:
                                        buyallvehicle[position]
                                            .fuelType
                                            .toString(),
                                        geartype:
                                        buyallvehicle[position]
                                            .gearType
                                            .toString(),
                                        seat:
                                        buyallvehicle[position]
                                            .noOfSeats
                                            .toString(),
                                        door:
                                        buyallvehicle[position]
                                            .noOfDoors
                                            .toString(),
                                        Ownerimge: buyallvehicle[
                                        position]
                                            .ownerProfilePhoto
                                            .toString(),
                                        Ownername:
                                        buyallvehicle[position]
                                            .ownerName
                                            .toString(),
                                        Ownerplace:
                                        buyallvehicle[position]
                                            .ownerPlace
                                            .toString(), price: buyallvehicle[position].rentPrice.toString(), id: buyallvehicle[position].id.toString(),
                                        carplace: place,places: places,
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
                                            width: 1.w, color: Color(0xFF58606A)),
                                        borderRadius: BorderRadius.circular(10.r),
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
                                                    buyallvehicle[position]
                                                        .photos![0]),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.r),
                                                  topRight: Radius.circular(8.r),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Text(
                                            buyallvehicle[position]
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
                                              SizedBox(
                                                width: 80.w,
                                                child: Text(
                                                  place!,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Color(0xFFF7F5F2),
                                                    fontSize: 14.sp,
                                                    fontFamily: 'sf pro display',
                                                    fontWeight: FontWeight.w300,
                                                    letterSpacing: 0.50.w,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "  \₹ ${buyallvehicle[position].rentPrice.toString()}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFFFFD66D),
                                                  fontSize: 13.sp,
                                                  fontFamily: 'SF Pro Display',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.50.w,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }):SizedBox();
                      },

                      separatorBuilder: (context, position) {
                        return  buyallvehicle[position].latestModel==true? SizedBox(
                          width: 10.w,
                        ):SizedBox();
                      },
                    ),
                  ),
                ),buyallvehicle.length==0 ?SizedBox():
                Padding(
                  padding: EdgeInsets.only(left: 10.w, top: 15.h),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 40.h,
                        child: Text(
                          'High Milage',
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
                  padding: EdgeInsets.only(left: 10.w, right: 10.w),
                  child: SizedBox(
                    width: double.infinity,
                    height: 223.h,
                    child: ListView.separated(
                      itemCount: buyallvehicle.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, position) {
                        return buyallvehicle[position].highMilage==true?
                        FutureBuilder(
                            future: _getVechileAddress(
                                buyallvehicle[position]
                                    .location!
                                    .coordinates!
                                    .first
                                    .toString(),
                                buyallvehicle[position]
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

                                return GestureDetector(onTap: (){
                                  Navigator.of(context)
                                      .push(MaterialPageRoute(
                                      builder: (_) => CarbuyDetails(
                                        carimage:
                                        buyallvehicle[position]
                                            .photos!
                                            .toList(),
                                        carname:
                                        buyallvehicle[position]
                                            .brand
                                            .toString(),
                                        ratting:
                                        buyallvehicle[position]
                                            .rating
                                            .toString(),
                                        tanktype:
                                        buyallvehicle[position]
                                            .fuelType
                                            .toString(),
                                        geartype:
                                        buyallvehicle[position]
                                            .gearType
                                            .toString(),
                                        seat:
                                        buyallvehicle[position]
                                            .noOfSeats
                                            .toString(),
                                        door:
                                        buyallvehicle[position]
                                            .noOfDoors
                                            .toString(),
                                        Ownerimge: buyallvehicle[
                                        position]
                                            .ownerProfilePhoto
                                            .toString(),
                                        Ownername:
                                        buyallvehicle[position]
                                            .ownerName
                                            .toString(),
                                        Ownerplace:
                                        buyallvehicle[position]
                                            .ownerPlace
                                            .toString(),
                                        carplace: place,places: places, price: buyallvehicle[position].rentPrice.toString(), id: buyallvehicle[position].id.toString(),
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
                                            width: 1.w, color: Color(0xFF58606A)),
                                        borderRadius: BorderRadius.circular(10.r),
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
                                                    buyallvehicle[position]
                                                        .photos![0]),
                                                fit: BoxFit.fill,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.r),
                                                  topRight: Radius.circular(8.r),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 15.h),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Text(
                                            buyallvehicle[position]
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
                                              SizedBox(
                                                width: 80.w,
                                                child: Text(
                                                  place!,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: Color(0xFFF7F5F2),
                                                    fontSize: 14.sp,
                                                    fontFamily: 'sf pro display',
                                                    fontWeight: FontWeight.w300,
                                                    letterSpacing: 0.50.w,
                                                  ),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                              ),
                                              SizedBox(width: 5.w),
                                              Text(
                                                "  \₹ ${buyallvehicle[position].rentPrice.toString()}",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color(0xFFFFD66D),
                                                  fontSize: 13.sp,
                                                  fontFamily: 'SF Pro Display',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.50.w,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              } else {
                                return SizedBox();
                              }
                            }):SizedBox();
                      },
                      separatorBuilder: (context, position) {
                        return buyallvehicle[position].highMilage==true? SizedBox(
                          width: 10.w,
                        ):SizedBox();
                      },
                    ),
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
                      child: GridView.count(
                        crossAxisCount: 2,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        childAspectRatio: 185 / 223,
                        children: List.generate(
                          buyallvehicle.length,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FutureBuilder(
                                  future: _getVechileAddress(
                                      buyallvehicle[index]
                                          .location!
                                          .coordinates!
                                          .first
                                          .toString(),
                                      buyallvehicle[index]
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
                                          child:
                                              Text("Error fetching location"));
                                    } else if (snapshot.hasData) {
                                      String? place =
                                          snapshot.data![0].locality;
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.of(context)
                                              .push(MaterialPageRoute(
                                                  builder: (_) => CarbuyDetails(
                                                        carimage:
                                                            buyallvehicle[index]
                                                                .photos!
                                                                .toList(),
                                                        carname:
                                                            buyallvehicle[index]
                                                                .brand
                                                                .toString(),
                                                        ratting:
                                                            buyallvehicle[index]
                                                                .rating
                                                                .toString(),
                                                        tanktype:
                                                            buyallvehicle[index]
                                                                .fuelType
                                                                .toString(),
                                                        geartype:
                                                            buyallvehicle[index]
                                                                .gearType
                                                                .toString(),
                                                        seat:
                                                            buyallvehicle[index]
                                                                .noOfSeats
                                                                .toString(),
                                                        door:
                                                            buyallvehicle[index]
                                                                .noOfDoors
                                                                .toString(),
                                                        Ownerimge: buyallvehicle[
                                                                index]
                                                            .ownerProfilePhoto
                                                            .toString(),
                                                        Ownername:
                                                            buyallvehicle[index]
                                                                .ownerName
                                                                .toString(),
                                                        Ownerplace:
                                                            buyallvehicle[index]
                                                                .ownerPlace
                                                                .toString(),
                                                      carplace: place,places: places, price:buyallvehicle[index].rentPrice.toString(), id:buyallvehicle[index].id.toString() ,
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
                                                          buyallvehicle[index]
                                                              .photos![index]),
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
                                                  buyallvehicle[index]
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
                                                    SizedBox(width: 80.w,
                                                      child: Text(
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
                                                        ), overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ),
                                                    Text(
                                                      "  \₹ ${buyallvehicle[index].rentPrice.toString()}",
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
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {
                                      return SizedBox();
                                    }
                                  }),
                            );
                          },
                        ),
                      )),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        }),
      ),
    );
  }
}
