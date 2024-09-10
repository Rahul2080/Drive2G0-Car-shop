import 'package:carousel_slider/carousel_slider.dart';
import 'package:drive2go/Bloc/BuyNearVehicles_Bloc/buy_near_vehicles_bloc.dart';
import 'package:drive2go/Bloc/OrderBuyVehicles_Bloc/order_buy_bloc.dart';
import 'package:drive2go/Repository/ModelClass/OrderBuyVehiclesModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Repository/ModelClass/BuyNearVehiclesModel.dart';
import '../BottomNavigation.dart';

class CarbuyDetails extends StatefulWidget {
  final List<String> carimage;
  final List<String> places;
  final String carname;
  final String ratting;
  final String price;
  final String id;
  final String tanktype;
  final String geartype;
  final String seat;
  final String door;
  final String Ownerimge;
  final String Ownername;
  final String Ownerplace;
  final String carplace;
  final String ownernumber;

  const CarbuyDetails(
      {super.key,
      required this.carimage,
      required this.carname,
      required this.ratting,
      required this.tanktype,
      required this.geartype,
      required this.seat,
      required this.door,
      required this.Ownerimge,
      required this.Ownername,
      required this.Ownerplace,
      required this.carplace,
      required this.places,
      required this.price,
      required this.id, required this.ownernumber});

  @override
  State<CarbuyDetails> createState() => _CarbuyDetailsState();
}

class _CarbuyDetailsState extends State<CarbuyDetails>
    with SingleTickerProviderStateMixin {
  GoogleMapController? _mapController;
  String? _currentAddress;
  Position? _currentPosition;
  LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  late List<BuyNearVehiclesModel> buynearvehicle;
  int currrentindex = 0;
  bool isfavarites = false;
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  late OrderBuyVehiclesModel orderBuyVehiclesModel;
  late AnimationController animationController;
  var formkey = GlobalKey<FormState>();

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 3));

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
        title: Center(
          child: Text(
            widget.carname,
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
                        ),
                      ),
                    ],
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
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Row(
                    children: [
                      RatingBar.builder(
                        itemSize: 20.sp,
                        initialRating: double.parse(widget.ratting),
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
                      SizedBox(width: 10.w),
                      Text(
                        widget.ratting,
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
                                    'Tank size',
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
                                    widget.geartype,
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
                                    widget.seat,
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
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(7.r)),
                            ),
                            child: ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(7.r)),
                                child: Image.network(
                                  widget.Ownerimge,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 20.w, top: 17.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.Ownername,
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
                                      widget.Ownerplace,
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
                          SizedBox(width: 70.w),
                          InkWell(onTap: () => launchURL(Uri.parse('https://wa.me/${widget.ownernumber}') ,false),
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
                            ),
                          )
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
                            return widget.id ==
                                    buynearvehicle[position].id.toString()
                                ? SizedBox()
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(MaterialPageRoute(
                                          builder: (_) => CarbuyDetails(
                                              carimage: buynearvehicle[position]
                                                  .photos!,
                                              carname: buynearvehicle[position]
                                                  .brand
                                                  .toString(),
                                              ratting: buynearvehicle[position]
                                                  .rating
                                                  .toString(),
                                              tanktype: buynearvehicle[position]
                                                  .fuelType
                                                  .toString(),
                                              geartype: buynearvehicle[position]
                                                  .gearType
                                                  .toString(),
                                              seat: buynearvehicle[position]
                                                  .noOfSeats
                                                  .toString(),
                                              door: buynearvehicle[position]
                                                  .noOfDoors
                                                  .toString(),
                                              Ownerimge: buynearvehicle[position]
                                                  .ownerProfilePhoto
                                                  .toString(),
                                              Ownername: buynearvehicle[position]
                                                  .ownerName
                                                  .toString(),
                                              Ownerplace:
                                                  buynearvehicle[position]
                                                      .ownerPlace
                                                      .toString(),
                                              carplace: widget.carplace,
                                              places: widget.places,
                                              price: buynearvehicle[position]
                                                  .rentPrice
                                                  .toString(),
                                              id: widget.id, ownernumber: buynearvehicle[position].ownerPhoneNumber.toString(),)));
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
                                                    widget.places[position],
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Color(0xFFF7F5F2),
                                                      fontSize: 14.sp,
                                                      fontFamily:
                                                          'sf pro display',
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      letterSpacing: 0.50.w,
                                                    ),
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Text(
                                                  "  \₹ ${buynearvehicle[position].rentPrice.toString()}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFFD66D),
                                                    fontSize: 13.sp,
                                                    fontFamily:
                                                        'SF Pro Display',
                                                    fontWeight: FontWeight.w500,
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
          Padding(
            padding: EdgeInsets.only(top: 750.h),
            child: Container(
              width: 430.w,
              height: 99.h,
              decoration: ShapeDecoration(
                color: Color(0x82C2C2C2),
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
                    Text(
                      " \₹ ${widget.price}",
                      style: TextStyle(
                        color: Color(0xFF000B17),
                        fontSize: 20.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(width: 70.w),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet<void>(
                          isScrollControlled: true,
                          context: context,
                          builder: (BuildContext context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Container(
                                width: double.infinity.w,
                                height: 450.h,
                                color: Colors.black,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Form(
                                    key: formkey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30.w, top: 20.h,right: 20.w),
                                          child:  TextFormField(
                                            controller: namecontroller,textInputAction: TextInputAction.next,
                                            cursorColor: Colors.white,
                                            style:
                                            TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFF627487),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.w,
                                                    color: Color(0xFF627487),
                                                  )),
                                              hintText: " Enter Your Name",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFFA7B0BB),
                                                  fontSize: 16.sp),
                                              filled: true,
                                              fillColor: Colors.black,
                                              focusColor: Colors.white
                                                  .withOpacity(
                                                  0.18000000715255737),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide:
                                                  BorderSide(width: 1.w)),
                                            ),
                                            validator: (name) {
                                              if (name!.isEmpty) {
                                                return 'enter Your Name';
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30.w,
                                              top: 20.h,
                                              right: 20.w),
                                          child:  TextFormField(
                                            controller: emailcontroller,textInputAction: TextInputAction.next,
                                            cursorColor: Colors.white,
                                            style:
                                            TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFF627487),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.w,
                                                    color: Color(0xFF627487),
                                                  )),
                                              hintText: "Enter Your Email..",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFFA7B0BB),
                                                  fontSize: 16.sp),
                                              filled: true,
                                              fillColor: Colors.black,
                                              focusColor: Colors.white
                                                  .withOpacity(
                                                  0.18000000715255737),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide:
                                                  BorderSide(width: 1.w)),
                                            ),
                                              validator: (emailvalue) {
                                                if (emailvalue!.isEmpty ||
                                                    !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(emailvalue)) {
                                                  return 'Enter a valid email!';
                                                }
                                                return null;
                                              },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30.w, top: 20.h,right: 20.h),
                                          child:  TextFormField(
                                            controller: addresscontroller,textInputAction: TextInputAction.next,
                                            cursorColor: Colors.white,
                                            style:
                                            TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1,
                                                    color: Color(0xFF627487),
                                                  )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                    width: 1.w,
                                                    color: Color(0xFF627487),
                                                  )),
                                              hintText: " Enter Your Address",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFFA7B0BB),
                                                  fontSize: 16.sp),
                                              filled: true,
                                              fillColor: Colors.black,
                                              focusColor: Colors.white
                                                  .withOpacity(
                                                  0.18000000715255737),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(
                                                      10.r),
                                                  borderSide:
                                                  BorderSide(width: 1.w)),
                                            ),
                                            validator: (address) {
                                              if (address!.isEmpty) {
                                                return 'Enter Your Address';
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: 30.w,
                                              top: 20.h,
                                              right: 20.w),
                                          child: TextFormField(
                                            controller: phonenumbercontroller,
                                            cursorColor: Colors.white,
                                            style:
                                                TextStyle(color: Colors.white),
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                width: 1,
                                                color: Color(0xFF627487),
                                              )),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                width: 1.w,
                                                color: Color(0xFF627487),
                                              )),
                                              hintText: "Phone Number",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFFA7B0BB),
                                                  fontSize: 16.sp),
                                              filled: true,
                                              fillColor: Colors.black,
                                              focusColor: Colors.white
                                                  .withOpacity(
                                                      0.18000000715255737),
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                  borderSide:
                                                      BorderSide(width: 1.w)),
                                            ),
                                            validator: (phonenumber) {
                                              if (phonenumber!.isEmpty ||
                                                  phonenumber.length < 10) {
                                                return 'enter 10 digit number';
                                              }

                                              return null;
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30.h,
                                        ),
                                        BlocListener<OrderBuyBloc,
                                            OrderBuyState>(
                                          listener: (context, state) {
                                            if (state
                                                is OrderBuyVehiclesBlocLoading) {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  );
                                                },
                                              );
                                            }
                                            if (state
                                                is OrderBuyVehiclesBlocError) {
                                              Navigator.of(context).pop();
                                              print('error');
                                            }
                                            if (state
                                                is OrderBuyVehiclesBlocLoaded) {
                                              Navigator.of(context).pop();
                                              showDialog(
                                                context: context,
                                                builder: (ctx) => AlertDialog(
                                                  content: Lottie.asset(
                                                    'assets/done.json',
                                                    repeat: false,
                                                    reverse: false,
                                                    onLoaded: (complete) {
                                                      animationController
                                                        ..duration =
                                                            complete.duration
                                                        ..forward();

                                                      animationController
                                                          .addStatusListener(
                                                              (status) {
                                                        if (status ==
                                                            AnimationStatus
                                                                .completed) {
                                                          Navigator.of(context)
                                                              .pushAndRemoveUntil(
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (_) =>
                                                                              Bottomnavigation()),
                                                                  (route) =>
                                                                      (false));
                                                        }
                                                      });
                                                    },
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          child: InkWell(
                                            onTap: () {
                                              final isValid = formkey
                                                  .currentState
                                                  ?.validate();
                                              if (isValid! ) {
                                                BlocProvider.of<OrderBuyBloc>(
                                                        context)
                                                    .add(FeatchOrderBuyVehicles(
                                                        vehicleid: widget.id,
                                                        buyername:
                                                            namecontroller.text,
                                                        buyerphonenumber:
                                                            phonenumbercontroller
                                                                .text,
                                                        buyeremail:
                                                            emailcontroller
                                                                .text,
                                                        buyeraddress:
                                                            addresscontroller
                                                                .text,
                                                        amount: double.parse(
                                                            widget.price)));
                                              }
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
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.r),
                                                ),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Buy Now',
                                                  style: TextStyle(
                                                    color: Color(0xFFF7F5F2),
                                                    fontSize: 20.sp,
                                                    fontFamily:
                                                        'sf pro display',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
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
                            'Buy Now',
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
          ),
        ],
      ),
    );
  }
}
