import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class CarbuyDetails extends StatefulWidget {
  const CarbuyDetails({super.key});

  @override
  State<CarbuyDetails> createState() => _CarbuyDetailsState();
}

class _CarbuyDetailsState extends State<CarbuyDetails> {
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
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    showAlertDialog(
        context, "Payment Successful", "Payment ID: ${response.paymentId}");
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


  @override
  int currrentindex = 0;
  bool isfavarites = false;

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: GestureDetector(onTap: (){Navigator.of(context).pop();},
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          title: Center(
            child: Text(
              'Audi R8 Coupe',
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
                      itemCount: 3,
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
                          child: Image.asset(
                            'assets/car.png',
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
                            'Audi R8 Coupé',
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
                                      color: Color(0xFFF627487),
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
                    padding: EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        RatingBar.builder(
                          itemSize: 20.sp,
                          initialRating: 1,
                          minRating: 1,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          ignoreGestures: true,
                          itemCount: 1,
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
                          '4.8 Reviews',
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
                    padding: EdgeInsets.only(left: 16.w,top: 20.h),
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
                              side:
                                  BorderSide(width: 1.w, color: Color(0xFF58606A)),
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
                                      '74 liters',
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
                              side:
                                  BorderSide(width: 1.w, color: Color(0xFF58606A)),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Row(
                              children: [
                                Icon(Icons.linear_scale_outlined,
                                    color: Color(0xFFA7B0BB)),
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
                                      'Automatic',
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
                              side:
                                  BorderSide(width: 1.w, color: Color(0xFF58606A)),
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
                                      '2',
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
                              side:
                                  BorderSide(width: 1.w, color: Color(0xFF58606A)),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.w),
                            child: Row(
                              children: [
                                Icon(Icons.sensor_door_outlined,
                                    color: Color(0xFFA7B0BB)),
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
                                      '4',
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
                      'Car Overview',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.calendar_month_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'Registration Year',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 105.w),
                        SizedBox(
                          width: 60.w,
                          height: 30.h,
                          child: Text(
                            '2015',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'Insurance Validity',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 57.w),
                        SizedBox(
                          width: 105.w,
                          height: 50.h,
                          child: Text(
                            'Third Party\nInsurance',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'Fuel Type',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 94.w),
                        SizedBox(
                          width: 60.w,
                          height: 30.h,
                          child: Text(
                            'Diesel',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.speed,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'Kilometers Driven',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 35.w),
                        SizedBox(
                          width: 120.w,
                          height: 30.h,
                          child: Text(
                            '1,20,000kms',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.water_drop_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'RTO',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 98.w),
                        SizedBox(
                          width: 60.w,
                          height: 30.h,
                          child: Text(
                            'HR23',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.person_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'Ownership',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 55.w),
                        SizedBox(
                          width: 96.w,
                          height: 30.h,
                          child: Text(
                            '3rd Owner',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.animation_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'Engine Displacement',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 80.w),
                        SizedBox(
                          width: 80.w,
                          height: 30.h,
                          child: Text(
                            '1995cc',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, top: 20.h),
                    child: Row(
                      children: [
                        Icon(
                          Icons.timelapse_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        SizedBox(width: 10.w),
                        SizedBox(
                          width: 200.w,
                          height: 30.h,
                          child: Text(
                            'Year of Manufature',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 100.w),
                        SizedBox(
                          width: 60.w,
                          height: 30.h,
                          child: Text(
                            '2015',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.50.w,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,top: 20.h),
                    child: Text(
                      'Features',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  SizedBox(width: double.infinity.w,height: 240.h,
                    child: Column(
                    children: [
                      Padding(
                            padding:  EdgeInsets.only(left: 20.w),
                            child: Row(children: [
                              Icon(Icons.done,color:Color(0xFFFFCE50),),
                              SizedBox(width: 10.w),
                              Text(
                                'Power Steering',
                                style: TextStyle(
                                  color: Color(0xFFA7B0BB),
                                  fontSize: 17.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.w,
                                ),
                              ),
                              SizedBox(width: 70.w,),
                              Icon(Icons.done,color:Color(0xFFFFCE50),),
                              SizedBox(width: 10.w),
                              Text(
                                'Power Window\nFront',
                                style: TextStyle(
                                  color: Color(0xFFA7B0BB),
                                  fontSize: 17.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w400,
                                  letterSpacing: 1.w,
                                ),
                              ),


                            ],),
                          ),
                      Padding(
                        padding:  EdgeInsets.only(left: 20.w,top: 15.h),
                        child: Row(children: [
                          Icon(Icons.done,color:Color(0xFFFFCE50),),
                          SizedBox(width: 10.w),
                          Text(
                            'Air Conditioner',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                          SizedBox(width: 70.w,),
                          Icon(Icons.done,color:Color(0xFFFFCE50),),
                          SizedBox(width: 10.w),
                          Text(
                            'Heater',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),


                        ],),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 20.w,top: 15.h),
                        child: Row(children: [
                          Icon(Icons.done,color:Color(0xFFFFCE50),),
                          SizedBox(width: 10.w),
                          Text(
                            'Adjustable Head\nLights',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                          SizedBox(width: 60.w,),
                          Icon(Icons.done,color:Color(0xFFFFCE50),),
                          SizedBox(width: 10.w),
                          Text(
                            'Fog Light Front',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),


                        ],),
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 20.w,top: 15.h),
                        child: Row(children: [
                          Icon(Icons.done,color:Color(0xFFFFCE50),),
                          SizedBox(width: 10.w),
                          Text(
                            'Anti Lock Braking\nSystem',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                          SizedBox(width: 50.w,),
                          Icon(Icons.done,color:Color(0xFFFFCE50),),
                          SizedBox(width: 10.w),
                          Text(
                            'Break Assist',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),


                        ],),
                      )

                    ],
                  ) ,),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w),
                    child: Text(
                      'Specification',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
              SizedBox(height: 10.h),

              SizedBox(width: double.infinity.w,height: 200.h,
              child:  Column(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        SizedBox(width: 200.w,height: 30.h,
                          child: Text(
                            'Mileage',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 100.w),
                        Text(
                          '18.12 kmpl',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 17.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.w,
                          ),
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,top: 10.h),
                    child: Row(
                      children: [
                        SizedBox(width: 220.w,height: 30.h,
                          child: Text(
                            'Engine',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 100.w),
                        Text(
                          '1995cc',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 17.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.w,
                          ),
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,top: 10.h),
                    child: Row(
                      children: [
                        SizedBox(width: 215.w,height: 30.h,
                          child: Text(
                            'Max Power',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 100.w),
                        Text(
                          '190 bhp',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 17.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.w,
                          ),
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,top: 10.h),
                    child: Row(
                      children: [
                        SizedBox(width: 215.w,height: 30.h,
                          child: Text(
                            'Wheel Size',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 100.w),
                        Text(
                          '400 Nm',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 17.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.w,
                          ),
                        )

                      ],
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,top: 10.h),
                    child: Row(
                      children: [
                        SizedBox(width: 265.w,height: 30.h,
                          child: Text(
                            'Seats',
                            style: TextStyle(
                              color: Color(0xFFA7B0BB),
                              fontSize: 17.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.w,
                            ),
                          ),
                        ),
                        SizedBox(width: 100.w),
                        Text(
                          '2',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 17.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.w,
                          ),
                        )

                      ],
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
                    padding:  EdgeInsets.only(left: 20.w,top: 20.h),
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
                                color: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(7.r)),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.all(Radius.circular(7.r)),
                                  child: Image.asset(
                                    'assets/car.png',
                                    fit: BoxFit.cover,
                                  )),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 30.w, top: 17.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'James Robert',
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
                                        'Kottakal',
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
                          Image.asset('assets/whatsapp.png',width: 30.w,height: 30.h,),
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
                    padding:  EdgeInsets.only(left: 20.w,top: 10.h),
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
                    padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 10.h),
                    child: SizedBox(
                      width: double.infinity,
                      height: 223.h,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (context, position) {
                          return Container(
                            width: 185.w,
                            height: 223.h,
                            decoration: ShapeDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(8, -0.54),
                                end: Alignment(-0.84, 0.54),
                                colors: [Colors.white, Colors.white.withOpacity(0)],
                              ),
                              shape: RoundedRectangleBorder(
                                side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
                                borderRadius: BorderRadius.circular(10.r),
                              ),
                            ),
                            child: Column(crossAxisAlignment:CrossAxisAlignment.start ,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    width: 187.w,
                                    height: 146.h,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            "assets/car.png"),
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
                                  padding:  EdgeInsets.only(left: 10.w),
                                  child: Text(
                                    'Audi R8 Coupé',
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
                                  padding:  EdgeInsets.only(left: 5.w),
                                  child: Row(
                                    children: [
                                      Icon(Icons.location_on_outlined,color: Color(0xFFF7F5F2),size: 20.sp,),

                                      Text(
                                        'Kottakal',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFF7F5F2),
                                          fontSize: 14.sp,
                                          fontFamily: 'sf pro display',
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.50.w,
                                        ),
                                      ),
                                      SizedBox(width: 20.w),

                                      Text(
                                        '\$ 8000 / day',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFFFFD66D),
                                          fontSize: 13.sp,
                                          fontFamily: 'SF Pro Display',
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.50.w,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              ],
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
                  SizedBox(height: 90.h),

                ],
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 750.h),
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
                ),child: Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: Row(
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '8000\$',
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

                    GestureDetector(onTap: (){
                      Razorpay razorpay = Razorpay();
                      var options = {
                        'key': 'rzp_test_gKANZdsNdLqaQs',
                        'amount': 100,
                        'name': 'Acme Corp.',
                        'description': 'Fine T-Shirt',
                        'retry': {'enabled': true, 'max_count': 1},
                        'send_sms_hash': true,
                        'prefill': {
                          'contact': '8888888888',
                          'email': 'test@razorpay.com'
                        },
                        'external': {
                          'wallets': ['paytm']
                        }
                      };
                      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
                          handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
                          handlePaymentSuccessResponse);
                      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
                          handleExternalWalletSelected);
                      razorpay.open(options);

                    },
                      child: Container(
                        width: 213.w,
                        height: 50.h,
                        decoration: ShapeDecoration(
                          gradient: RadialGradient(
                            center: Alignment(.05, 1),
                            colors: [Color(0xFFFFCE50), Color(0xFFFFF0C9), Color(0xFFFFDB81), Color(0xFFD39906), Color(0xFFFFCE50), Color(0xFFD39906)],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),child: Center(
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
