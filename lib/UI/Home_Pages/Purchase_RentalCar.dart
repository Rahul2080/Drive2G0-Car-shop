import 'package:date_picker_plus/date_picker_plus.dart';
import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
//import 'package:location/location.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import 'PickUp_Location.dart';
import 'Return_Location.dart';
class PurchaseRentalcar extends StatefulWidget {
  const PurchaseRentalcar({super.key});

  @override
  State<PurchaseRentalcar> createState() => _PurchaseRentalcarState();
}

class _PurchaseRentalcarState extends State<PurchaseRentalcar> {
  TextEditingController pickupdatecontroller = TextEditingController();
  TextEditingController returneddatecontroller = TextEditingController();

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
  Future<void> pickupdatePicker(BuildContext context) async {
    final pickupdate = await showDatePickerDialog(
      context: context,
      initialDate: DateTime(2022, 10, 10),
      minDate: DateTime(2020, 10, 10),
      maxDate: DateTime(2024, 10, 30),
      width: 300.w,
      height: 300.h,
      currentDate: DateTime(2022, 10, 15),
      selectedDate: DateTime(2022, 10, 16),
      currentDateDecoration: const BoxDecoration(),
      currentDateTextStyle: const TextStyle(),
      daysOfTheWeekTextStyle: const TextStyle(),
      disabledCellsDecoration: const BoxDecoration(),
      disabledCellsTextStyle: const TextStyle(),
      enabledCellsDecoration: const BoxDecoration(),
      enabledCellsTextStyle: const TextStyle(),
      initialPickerType: PickerType.days,
      selectedCellDecoration: const BoxDecoration(),
      selectedCellTextStyle: const TextStyle(),
      leadingDateTextStyle: const TextStyle(),
      slidersColor: Colors.lightBlue,
      highlightColor: Colors.redAccent,
      slidersSize: 20.sp,
      splashColor: Colors.lightBlueAccent,
      splashRadius: 40.r,
      centerLeadingDate: true,
    );

    if (pickupdate != null) {
      setState(() {
        pickupdatecontroller.text = DateFormat('dd-MM-yyyy').format(pickupdate);
      });
    }
  }

  Future<void> returneddatepicker(BuildContext context) async {
    final returneddate = await showDatePickerDialog(
      context: context,
      initialDate: DateTime(2022, 10, 10),
      minDate: DateTime(2020, 10, 10),
      maxDate: DateTime(2024, 10, 30),
      width: 300.w,
      height: 300.h,
      currentDate: DateTime(2022, 10, 15),
      selectedDate: DateTime(2022, 10, 16),
      currentDateDecoration: const BoxDecoration(),
      currentDateTextStyle: const TextStyle(),
      daysOfTheWeekTextStyle: const TextStyle(),
      disabledCellsDecoration: const BoxDecoration(),
      disabledCellsTextStyle: const TextStyle(),
      enabledCellsDecoration: const BoxDecoration(),
      enabledCellsTextStyle: const TextStyle(),
      initialPickerType: PickerType.days,
      selectedCellDecoration: const BoxDecoration(),
      selectedCellTextStyle: const TextStyle(),
      leadingDateTextStyle: const TextStyle(),
      slidersColor: Colors.lightBlue,
      highlightColor: Colors.redAccent,
      slidersSize: 20.sp,
      splashColor: Colors.lightBlueAccent,
      splashRadius: 40.r,
      centerLeadingDate: true,
    );
    if (returneddate != null) {
      setState(() {
        returneddatecontroller.text =
            DateFormat("dd-MM-yyyy").format(returneddate);
      });
    }
  }


@override
  void initState() {

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Renting Details',
          style: TextStyle(
            color: Color(0xFFF7F5F2),
            fontSize: 24.sp,
            fontFamily: 'sf pro display',
            fontWeight: FontWeight.w600,
            letterSpacing: 0.24.sp,
          ),
        ),
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.h,left: 20.w),
                  child: Container(
                    width: 380.w,
                    height: 123.h,
                    decoration: ShapeDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(7, -0.54),
                        end: Alignment(-0.84, 0.54),
                        colors: [Colors.white, Colors.white.withOpacity(0)],
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 10.w),
                        Container(
                          width: 127.w,
                          height: 102.h,
                          decoration: ShapeDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/car.png"),
                              fit: BoxFit.cover,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.r)),
                          ),
                        ),
                        SizedBox(width: 25.w),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              'Audi R8 Coupé',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFFF7F5F2),
                                fontSize: 20.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w500,
                              ),
                            ),

                            Text(
                              'White',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF627487),
                                fontSize: 16.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '8000\$/Day',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_month_outlined,
                        color: Color(0xFFF7F5F2),
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Select Date',
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 16.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 30.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 150.w,
                        height: 90.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 148.w,
                              height: 55.h,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.w, color: Color(0xFF627487)),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              child: TextField(
                                controller: pickupdatecontroller,
                                cursorColor: Colors.white,
                                style: TextStyle(color: Color(0xFF627487)),
                                decoration: InputDecoration(
                                  hintText: "DD/MM/YYYY",
                                  hintStyle: TextStyle(color: Color(0xFF627487)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                                onTap: () {
                                  pickupdatePicker(context);
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Pickup Date',
                              style: TextStyle(
                                color: Color(0xFF627487),
                                fontSize: 14.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      Image.asset(
                        "assets/arrow.png",
                        width: 60.w,
                        height: 50.h,
                      ),
                      SizedBox(width: 10.w),
                      SizedBox(
                        width: 160.w,
                        height: 90.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 148.w,
                              height: 55.h,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      width: 1.w, color: Color(0xFF627487)),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                              ),
                              child: TextField(
                                controller: returneddatecontroller,
                                style: TextStyle(color: Color(0xFF627487)),
                                decoration: InputDecoration(
                                  hintText: "DD/MM/YYYY",
                                  hintStyle: TextStyle(color: Color(0xFF627487)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                ),
                                onTap: () {
                                  returneddatepicker(context);
                                },
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Return Date',
                              style: TextStyle(
                                color: Color(0xFF627487),
                                fontSize: 14.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 10.w,top: 20.h),
                  child: Row(
                    children: [
                      Icon(Icons.location_on_outlined,color: Color(0xFFF7F5F2) ,),
                      SizedBox(width: 5.w),

                      Text(
                        'Select Location',
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 16.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 20.w,top: 20.h),
                  child: Container(
                    width: 372.w,
                    height: 55.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.w, color: Color(0xFF627487)),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),child: TextField(controller: pickuplocationcontroller, style: TextStyle(color: Color(0xFF627487),),
                    decoration: InputDecoration(
                      hintText: "Type your location or search in map",
                      hintStyle: TextStyle(color: Color(0xFF627487)),
                      suffixIcon: GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PickUp_Location()));},
                          child: Icon(Icons.map_outlined,color:Color(0xFF627487) ,)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 20.w,top: 10.h),
                  child: Text(
                    'Pickup location',
                    style: TextStyle(
                      color: Color(0xFF627487),
                      fontSize: 14.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 20.w,top: 20.h),
                  child: Container(
                    width: 372.w,
                    height: 55.h,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(width: 1.w, color: Color(0xFF627487),),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),child: TextField(controller: returnlocationcontroller,
                    style: TextStyle(color: Color(0xFF627487),),
                    decoration: InputDecoration(
                      hintText: "Type your location or search in map",
                      hintStyle: TextStyle(color: Color(0xFF627487)),
                      suffixIcon: GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>ReturnLocation()));},
                          child: Icon(Icons.map_outlined,color:Color(0xFF627487) ,)),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                    ),
                  ),
                  ),
                ),
                Padding(
                  padding:  EdgeInsets.only(left: 20.w,top: 10.h),
                  child: Text(
                    'Return location',
                    style: TextStyle(
                      color: Color(0xFF627487),
                      fontSize: 14.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),


              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(top: 740.h),
            child: Container(
              width: 450.w,
              height: 99.h,
              decoration: ShapeDecoration(
                color:Colors.white.withOpacity(0.7344567788),
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
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15.h),

                      Text(
                        'RENTAL PRICE FOR ',
                        style: TextStyle(
                          color: Color(0xFF1F354D),
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        '14 Days - 1,12,000\$',
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 18.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w700,
                        ),
                      )

                    ],
                  ),
                  SizedBox(width: 30.w),

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
                      width: 190.w,
                      height: 50.h,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
begin: Alignment.topCenter,end: Alignment.bottomCenter,
                          colors: [Color(0xFFFFF0C9),Color(0xFFFFCE50),  Color(0xFFD39906),  ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),child: Center(
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
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    setState(() {
      pickuplocationcontroller.clear();
    });

    // TODO: implement dispose
    super.dispose();
  }
}
