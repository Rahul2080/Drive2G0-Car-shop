import 'package:drive2go/IntroPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Row(
                children: [
                  Container(
                    width: 219.w,
                    height: 65.h,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'location ',
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 20.sp,
                            fontFamily: 'sf pro displa',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Malappuram , Kerala',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFFF7F5F2),
                            fontSize: 20.sp,
                            fontFamily: 'sf pro displa',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 138.w),
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

            Container(
              width: 292.w,
              height: 48.h,
              decoration: ShapeDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0.84, -0.54),
                  end: Alignment(-0.84.w, 0.54),
                  colors: [Colors.white, Colors.white.withOpacity(0)],
                ),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            )

          ],
        ));
  }
}
