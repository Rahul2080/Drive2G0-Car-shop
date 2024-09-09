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
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../Repository/ModelClass/BuyNearVehiclesModel.dart';

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

  const CarbuyDetails({super.key,
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
    required this.id});

  @override
  State<CarbuyDetails> createState() => _CarbuyDetailsState();
}

class _CarbuyDetailsState extends State<CarbuyDetails> {
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

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    showAlertDialog(context, "Payment Failed",
        "Code: ${response.code}\nDescription: ${response
            .message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
     BlocProvider.of<OrderBuyBloc>(context).add(
        FeatchOrderBuyVehicles(vehicleid: widget.id,
            buyername: namecontroller.text,
            buyerphonenumber: phonenumbercontroller.text,
            buyeremail: emailcontroller.text,
            buyeraddress: addresscontroller.text,
            amount: double.parse(widget.price)));
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
    Navigator.of(context).pop();
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
        context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    // set up the buttons
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
                        itemBuilder: (context, _) =>
                            Icon(
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
                          Image.asset(
                            'assets/whatsapp.png',
                            width: 30.w,
                            height: 30.h,
                          ),
                          SizedBox(width: 20.w),
                          Icon(
                            Icons.wifi_calling_3_outlined,
                            color: Colors.white,
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
                                BlocProvider
                                    .of<BuyNearVehiclesBloc>(context)
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
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                CarbuyDetails(
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
                                                    id: widget.id)));
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
                                                "  \₹ ${buynearvehicle[position]
                                                    .rentPrice.toString()}",
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
                                  MediaQuery
                                      .of(context)
                                      .viewInsets
                                      .bottom),
                              child: Container(
                                width: double.infinity.w,
                                height: 400.h,
                                color: Colors.black,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, top: 20.h),
                                        child: Container(
                                          width: 372.w,
                                          height: 55.h,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1.w,
                                                color: Color(0xFF627487),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          child: TextField(
                                            style:
                                            TextStyle(color: Colors.white),
                                            controller: namecontroller,
                                            cursorColor: Colors.white,
                                            decoration: InputDecoration(
                                              hintText: "Enter Your Name.. ",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF627487)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, top: 20.h),
                                        child: Container(
                                          width: 372.w,
                                          height: 55.h,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1.w,
                                                color: Color(0xFF627487),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          child: TextField(
                                            style:
                                            TextStyle(color: Colors.white),
                                            cursorColor: Colors.white,
                                            controller: emailcontroller,
                                            decoration: InputDecoration(
                                              hintText: "Enter Your Email.. ",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF627487)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, top: 20.h),
                                        child: Container(
                                          width: 372.w,
                                          height: 55.h,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1.w,
                                                color: Color(0xFF627487),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          child: TextField(
                                            style:
                                            TextStyle(color: Colors.white),
                                            controller: addresscontroller,
                                            cursorColor: Colors.white,
                                            decoration: InputDecoration(
                                              hintText: "Enter Your Address.. ",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF627487)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 20.w, top: 20.h),
                                        child: Container(
                                          width: 372.w,
                                          height: 55.h,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1.w,
                                                color: Color(0xFF627487),
                                              ),
                                              borderRadius:
                                              BorderRadius.circular(4.r),
                                            ),
                                          ),
                                          child: TextField(
                                            style:
                                            TextStyle(color: Colors.white),
                                            cursorColor: Colors.white,
                                            controller: phonenumbercontroller,
                                            decoration: InputDecoration(
                                              hintText:
                                              "Enter Your phone number.. ",
                                              hintStyle: TextStyle(
                                                  color: Color(0xFF627487)),
                                              border: OutlineInputBorder(
                                                  borderSide: BorderSide.none),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.h,
                                      ),
                                      BlocListener<OrderBuyBloc, OrderBuyState>(
                                        listener: (context, state) {
                                          if (state
                                          is OrderBuyVehiclesBlocLoading) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
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
                                          }
                                        },
                                        child: InkWell(
                                          onTap: () {
                                            if (namecontroller
                                                .text.isNotEmpty ||
                                                emailcontroller
                                                    .text.isNotEmpty ||
                                                addresscontroller
                                                    .text.isNotEmpty ||
                                                phonenumbercontroller
                                                    .text.isNotEmpty) {
                                              Razorpay razorpay = Razorpay();
                                              var options = {
                                                'key':
                                                'rzp_test_gKANZdsNdLqaQs',
                                                'amount': 100,
                                                'name': 'Acme Corp.',
                                                'description': 'Fine T-Shirt',
                                                'retry': {
                                                  'enabled': true,
                                                  'max_count': 1
                                                },
                                                'send_sms_hash': true,
                                                'prefill': {
                                                  'contact': '8888888888',
                                                  'email': 'test@razorpay.com'
                                                },
                                                'external': {
                                                  'wallets': ['paytm']
                                                }
                                              };
                                              razorpay.on(
                                                  Razorpay.EVENT_PAYMENT_ERROR,
                                                  handlePaymentErrorResponse);
                                              razorpay.on(
                                                  Razorpay
                                                      .EVENT_PAYMENT_SUCCESS,
                                                  handlePaymentSuccessResponse);
                                              razorpay.on(
                                                  Razorpay
                                                      .EVENT_EXTERNAL_WALLET,
                                                  handleExternalWalletSelected);
                                              razorpay.open(options);
                                            } else {
                                              showDialog(
                                                context: context,
                                                builder: (ctx) =>
                                                    AlertDialog(
                                                      title: Text(
                                                        "Enter your Details Completely",
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.black,
                                                          fontFamily:
                                                          'sf pro display',
                                                          fontWeight:
                                                          FontWeight.w700,
                                                        ),
                                                      ),
                                                    ),
                                              );
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
                                                BorderRadius.circular(10.r),
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
                                        ),
                                      ),
                                    ],
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
