import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CarDetails extends StatefulWidget {
  const CarDetails({super.key});

  @override
  State<CarDetails> createState() => _CarDetailsState();
}

class _CarDetailsState extends State<CarDetails> {
  int currrentindex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.arrow_back,
          color: Colors.white,
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
      body: Column(
        children: [
          Container(
            width: 430.w,
            height: 303.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(6, -1.00),
                end: Alignment(0.1, 1),
                colors: [Colors.white, Color(0xFF000B17)],
              ),
            ),
            child: CarouselSlider.builder(
              itemCount: 4,
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) =>
                      Container(
                width: 315.w,
                height: 254.h,
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
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
                  height: 200.h,
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
                SizedBox(width: 150.w),
                SizedBox(
                    width: 50.w,
                    height: 40.h,
                    child: Icon(
                      Icons.favorite_border,
                      color: Color(0xFFF627487),
                      size: 35.sp,
                    )),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10.w),
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
            padding: EdgeInsets.only(left: 10.w, top: 20.h),
            child: Row(
              children: [
                SizedBox(
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
                SizedBox(width: 150.w),
                SizedBox(
                  width: 80.w,
                  height: 40.h,
                  child: Text(
                    'more',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF627487),
                      fontSize: 16,
                      fontFamily: 'SF Pro Display',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:  EdgeInsets.only(left: 16.w),
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
                    padding:  EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Icon(Icons.local_gas_station, color: Color(0xFFA7B0BB)),SizedBox(width: 10.w,),
                        Column(
                          children: [SizedBox(height: 6.h),
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
                    padding:  EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Icon(Icons.linear_scale_outlined, color: Color(0xFFA7B0BB)),SizedBox(width: 10.w,),
                        Column(
                          children: [SizedBox(height: 6.h),
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
            padding:  EdgeInsets.only(left: 16.w,top: 20.h),
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
                    padding:  EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Icon(Icons.local_gas_station, color: Color(0xFFA7B0BB)),SizedBox(width: 10.w,),
                        Column(
                          children: [SizedBox(height: 6.h),
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
                    padding:  EdgeInsets.only(left: 20.w),
                    child: Row(
                      children: [
                        Icon(Icons.linear_scale_outlined, color: Color(0xFFA7B0BB)),SizedBox(width: 10.w,),
                        Column(
                          children: [SizedBox(height: 6.h),
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
        ],
      ),
    );
  }
}
