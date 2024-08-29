import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Login.dart';

class Intropage extends StatefulWidget {
  const Intropage({super.key});

  @override
  State<Intropage> createState() => _IntropageState();
}

class _IntropageState extends State<Intropage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Image.asset("assets/introimage.png"),
          Image.asset("assets/introcarimage.png"),

          Positioned(
            left: 73.w,
            top: 171.h,
            child: Text(
              'Wheels You Needed',
              style:  TextStyle(
                  color: Colors.white,
                  fontSize: 32.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Positioned(
            left: 59.w,
            top: 243.h,
            child: SizedBox(
              width: 323.w,
              child: Text(
                'Premium and prestige daily rental car, experience the thrill at a lower price.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF8493A3),
                  fontSize: 16.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.36.w,
                ),
              ),
            ),
          ),
          Positioned(
            left: 49.w,
            top: 727.h,
            child: GestureDetector(onTap: (){Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Login()));},
              child: Container(
                width: 332.w,
                height: 64.h,
                decoration: ShapeDecoration(
                  color: Color(0xBC001024),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.w, color: Color(0xFF001B39)),
                    borderRadius: BorderRadius.circular(50.r),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Let’s Go',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.70.w,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
