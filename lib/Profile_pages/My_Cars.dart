import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyCars extends StatefulWidget {
  const MyCars({super.key});

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,leading: GestureDetector(onTap: (){Navigator.of(context).pop();},
          child: Icon(Icons.arrow_back,color: Colors.white,)),),
      body: ListView.separated(
        itemCount: 5,

        itemBuilder: (context, position) {
          return    Padding(
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
          );
        },
        separatorBuilder: (context, position) {
          return SizedBox(height: 10.h,);
        },
      ),
    );
  }
}
