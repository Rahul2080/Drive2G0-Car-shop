import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.menu,
          color: Colors.white,
        ),
        actions: [
          Icon(
            Icons.settings_outlined,
            color: Colors.white,
          ),
          SizedBox(width: 10.w),
          Icon(
            Icons.notifications_none_outlined,
            color: Colors.white,
          ),
          SizedBox(width: 10.w),
          Icon(
            Icons.more_vert,
            color: Colors.white,
          ),
          SizedBox(width: 10.w),
        ],
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Padding(
                padding:  EdgeInsets.only(left: 20.w,top: 20.h),
                child: SizedBox(width: 300.w,height: 110.h,
                child: Row(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 94.w,
                      height: 94.h,
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
                      ),child: ClipRRect(borderRadius: BorderRadius.circular(7.r),child: Image.asset('assets/car.png',fit:BoxFit.cover,)),
                    ),
                    SizedBox(width: 20.w),
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        Text(
                          'James Robert',
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 22.sp,
                            fontFamily: 'sf pro display',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        SizedBox(height: 5.h),

                        Text(
                          'Individual profile',
                          style: TextStyle(
                            color: Color(0xFFA7B0BB),
                            fontSize: 14.sp,
                            fontFamily: 'SF Pro Display',
                            fontWeight: FontWeight.w400,
                            letterSpacing: 0.35,
                          ),
                        )


                      ],
                    )
                  ],
                ),

                ),
              ),
              Positioned(
                left: 92.w,
                top: 93.h,
                child: Container(
                  width: 30.w,
                  height: 30.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFFFCE50),
                    shape: OvalBorder(),
                  ),child: Icon(Icons.edit_outlined,color: Colors.white,),
                ),
              ) ,
            ],
          ),
          SizedBox(height: 50.h),


          Padding(
            padding: EdgeInsets.only(left: 20.w),
            child: Container(
              width: 391.w,
              height: 129.h,
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
              child: Row(
                children: [
                  Container(
                    width: 134.w,
                    height: 121.h,
                    decoration: ShapeDecoration(
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.r)),
                    ),
                    child: Image.asset(
                      "assets/car.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.h),
                      Text(
                        'Car name',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 16.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        'James Robert',
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '2022',
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 12.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '1000 km',
                        style: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 12.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 50.w, top: 90.h),
                    child: Text(
                      '\$5000 / day',
                      style: TextStyle(
                        color: Color(0xFFFFD66D),
                        fontSize: 16.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
