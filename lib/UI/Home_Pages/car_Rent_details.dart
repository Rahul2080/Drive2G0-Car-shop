import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Purchase_RentalCar.dart';

class CarRentDetails extends StatefulWidget {
  final List<dynamic> image;
  final String carname;
  final String rating;
  const CarRentDetails({super.key, required this.image, required this.carname, required this.rating});

  @override
  State<CarRentDetails> createState() => _CarRentDetailsState();
}

class _CarRentDetailsState extends State<CarRentDetails> {
  int currrentindex = 0;
  bool isfavarites = false;
  bool _isVisible = false;

  void _toggleVisibility() {
    setState(() {
      _isVisible = !_isVisible;
    });
  }

  @override
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
                    itemCount: widget.image.length,
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
                        widget.image[index],
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
                      "  ${widget.rating} \Reviews",
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
                            side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
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
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                            side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Row(
                            children: [
                              SizedBox(width: 25.w,height: 30.h,
                                  child: Image.asset("assets/gear.png")),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                            side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
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
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                            side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(left: 20.w),
                          child: Row(
                            children: [
                              SizedBox(width: 25.w,height: 30.h,
                              child: Image.asset("assets/door.png"),),
                              SizedBox(
                                width: 10.w,
                              ),
                              Column(crossAxisAlignment: CrossAxisAlignment.start,
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
                          Icon(
                            Icons.messenger_outline,
                            color: Colors.white,
                          ),
                          SizedBox(width: 25.w),
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

                  GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PurchaseRentalcar()));},
                    child: Container(
                      width: 213.w,
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
}
