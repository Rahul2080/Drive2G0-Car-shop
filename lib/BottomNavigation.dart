import 'package:drive2go/BuyCar.dart';
import 'package:drive2go/Profile.dart';
import 'package:drive2go/Search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Home.dart';

class Bottomnavigation extends StatefulWidget {
  const Bottomnavigation({super.key});

  @override
  State<Bottomnavigation> createState() => _BottomnavigationState();
}

class _BottomnavigationState extends State<Bottomnavigation> {
  final screens = [Home(), Search(), Buycar(), Profile()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          screens[currentIndex],
          Padding(
            padding: EdgeInsets.only(top: 830.h),
            child: Container(
              decoration: ShapeDecoration(
                color: Colors.white.withOpacity(0.7344567788),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.r),),
                ),
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              child: BottomNavigationBar(selectedLabelStyle: TextStyle(fontSize: 0.sp),
                backgroundColor: Colors.transparent,
                type: BottomNavigationBarType.fixed,
                onTap: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                items: [
              BottomNavigationBarItem(
              icon: currentIndex == 0
              ? Container(
                width: 52.w,
                height: 52.h,
                decoration: ShapeDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(0.00, -1.00),
                      end: Alignment(0, 1),
                      colors: [
                        Colors.white.withOpacity(
                            0.5899999737739563),
                        Color(0xD69E9E9E)
                      ],
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(11.r),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4.r,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]),
                child: Column(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(Icons.home,color:  Color(0xFF1F354D),),
                    SizedBox(
                      height: 3.h,
                    ),
                    Text(
                      "Home",
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10.sp,
                          fontFamily: "sf pro display",
                          fontStyle: FontStyle.normal,
                          color: Color(0xff20354E),),
                    ),
                  ],
                ),
              )
                    : Column(
            children: [
            Icon(Icons.home,color: Color(0xFF1F354D),),
          SizedBox(
            height: 3.h,
          ),
          Text(
            "Home",
            style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 10.sp,
                fontFamily: "sf pro display",
                fontStyle: FontStyle.normal,
                color: Color(0xff20354E)),
          ),
        ],
      ),
        label: ""),
                  BottomNavigationBarItem(
                      icon: currentIndex == 1
                          ? Container(
                        width: 52.w,
                        height: 52.h,
                        decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Colors.white.withOpacity(
                                    0.5899999737739563),
                                Color(0xD69E9E9E)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11.r),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4.r,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(Icons.search),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              "search",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10.sp,
                                  fontFamily: "sf pro display",
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff20354E)),
                            ),
                          ],
                        ),
                      )
                          : Column(
                        children: [
                         Icon(Icons.search),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "search",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                fontFamily: "sf pro display",
                                fontStyle: FontStyle.normal,
                                color: Color(0xff20354E)),
                          ),
                        ],
                      ),
                      label: "j"),
                  BottomNavigationBarItem(
                      icon: currentIndex == 2
                          ? Container(
                        width: 52.w,
                        height: 52.h,
                        decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Colors.white.withOpacity(
                                    0.5899999737739563),
                                Color(0xD69E9E9E)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11.r),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4.r,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(Icons.shopping_bag_outlined),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              "Buy Car",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10.sp,
                                  fontFamily: "sf pro display",
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff20354E)),
                            ),
                          ],
                        ),
                      )
                          : Column(
                        children: [
                          Icon(Icons.shopping_bag_outlined),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "Buy Car",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                fontFamily: "sf pro display",
                                fontStyle: FontStyle.normal,
                                color: Color(0xff20354E)),
                          ),
                        ],
                      ),
                      label: "j"),
                  BottomNavigationBarItem(
                      icon: currentIndex == 3
                          ? Container(
                        width: 52.w,
                        height: 52.h,
                        decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(0.00, -1.00),
                              end: Alignment(0, 1),
                              colors: [
                                Colors.white.withOpacity(
                                    0.5899999737739563),
                                Color(0xD69E9E9E)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                              BorderRadius.circular(11.r),
                            ),
                            shadows: [
                              BoxShadow(
                                color: Color(0x3F000000),
                                blurRadius: 4.r,
                                offset: Offset(0, 4),
                                spreadRadius: 0,
                              )
                            ]),
                        child: Column(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text(
                              "Profile",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 10.sp,
                                  fontFamily: "sf pro display",
                                  fontStyle: FontStyle.normal,
                                  color: Color(0xff20354E)),
                            ),
                          ],
                        ),
                      )
                          : Column(
                        children: [
                          Icon(Icons.person),
                          SizedBox(
                            height: 3.h,
                          ),
                          Text(
                            "Profile",
                            style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontSize: 10.sp,
                                fontFamily: "sf pro display",
                                fontStyle: FontStyle.normal,
                                color: Color(0xff20354E)),
                          ),
                        ],
                      ),
                      label: "j"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
