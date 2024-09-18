import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 140.h),
          Stack(
            children: [
              Container(
                alignment: Alignment.center,
                width: 180.w,
                height: 180.h,
                decoration: ShapeDecoration(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r))),
              ),
              Positioned(top: 120.h,left: 120.w,
                  child: CircleAvatar(
                      radius: 28.r,
                      backgroundColor: Colors.grey,
                      child: Icon(
                        Icons.photo,
                        size: 30.sp,
                      )))
            ],
          ),
          SizedBox(height: 30.h),
          Row(
            children: [
              SizedBox(width: 30.w),
              Icon(Icons.person_outline_outlined,color: Colors.white,),
              SizedBox(
                width: 20.w,
              ),
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(width: 200.w),
              Icon(
                Icons.edit_outlined,
                color: Colors.green,
                size: 30.sp,
              )
            ],
          ),SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 30.w),
              Icon(Icons.mail_outline,color: Colors.white,),
              SizedBox(
                width: 20.w,
              ),
              Text(
                'Edit Profile',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 30.w),
              Icon(Icons.phone,color: Colors.white,),
              SizedBox(
                width: 20.w,
              ),
              Text(
                ' 1234567890',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              SizedBox(width: 30.w),
              Icon(Icons.lock_outline,color: Colors.white,),
              SizedBox(
                width: 20.w,
              ),
              Text(
                'Password Change',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
