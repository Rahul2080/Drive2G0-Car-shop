
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Buy_Car_Search.dart';
import 'CarBuy_Details.dart';

class Buycar extends StatefulWidget {
  const Buycar({super.key});

  @override
  State<Buycar> createState() => _BuycarState();
}

class _BuycarState extends State<Buycar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>BuyCarSearch()));},
                    child: Container(
                      width: 292.w,
                      height: 48.h,
                      decoration: ShapeDecoration(
                        gradient: LinearGradient(
                          begin: Alignment(5, -0.54),
                          end: Alignment(-0.34, 0.54),
                          colors: [Colors.white, Colors.white.withOpacity(0)],
                        ),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
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
                      'Latest Model ',
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
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, position) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (_) => CarbuyDetails()));
                      },
                      child: Container(
                        width: 185.w,
                        height: 223.h,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(4, -0.54),
                            end: Alignment(-0.84, 0.54),
                            colors: [Colors.white, Colors.white.withOpacity(0)],
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: Color(0xFF58606A)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1),
                              child: Container(
                                width: 187.w,
                                height: 146.h,
                                decoration: ShapeDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/car.png"),
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
                              padding: EdgeInsets.only(left: 5.w),
                              child: Row(
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
                                  )
                                ],
                              ),
                            )
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
              padding: EdgeInsets.only(left: 10.w),
              child: SizedBox(
                width: 410.w,
                height: 760.h,
                child: GridView.count(
                  crossAxisCount: 2,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  childAspectRatio: 185 / 223,
                  children: List.generate(
                    10,
                    (index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>CarbuyDetails()));},
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(1),
                                  child: Container(
                                    width: 197.w,
                                    height: 146.h,
                                    decoration: ShapeDecoration(
                                      image: DecorationImage(
                                        image: AssetImage("assets/car.png"),
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
                                SizedBox(height: 10.h),
                                Padding(
                                  padding: EdgeInsets.only(left: 10.w),
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
                                  padding: EdgeInsets.only(left: 5.w),
                                  child: Row(
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
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
