import 'package:drive2go/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          GestureDetector(onTap:(){
            showModalBottomSheet<void>(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: 180.h,
                  child: Center(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        SizedBox(height: 10.h),
                        SizedBox(width: double.infinity.w,height: 60.h,
                          child: Padding(
                            padding:  EdgeInsets.only(left: 20.w,top: 30.h),
                            child: Text(
                              'Share profile',
                              style: TextStyle(
                                color: Color(0xFF000B17),
                                fontSize: 15.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                          child: Divider(),
                        ),
                        SizedBox(width: double.infinity.w,height: 60.h,
                          child: Padding(
                            padding:  EdgeInsets.only(left: 20.w,top: 15.h),
                            child: Text(
                              'Copy Link',
                              style: TextStyle(
                                color: Color(0xFF000B17),
                                fontSize: 15.sp,
                                fontFamily: 'sf pro display',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),


                      ],
                    ),
                  ),
                );
              },
            );


          },
              child: Icon(Icons.more_vert)),
          SizedBox(
            width: 15.w,
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 20.h),
                  child: SizedBox(
                    width: 300.w,
                    height: 110.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          width: 94.w,
                          height: 94.h,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(7.r)),
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(7.r),
                              child: Image.asset(
                                'assets/car.png',
                                fit: BoxFit.cover,
                              )),
                        ),
                        SizedBox(width: 20.w),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20.h),
                            Text(
                              'James Robert',
                              style: TextStyle(
                                color: Colors.black,
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
                            ),
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
                    ),
                    child: Icon(
                      Icons.edit_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.w, right: 50.w),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Text(
                'Account settings',
                style: TextStyle(
                  color: Color(0xFF929191),
                  fontSize: 12.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.settings_outlined),
                  SizedBox(width: 20.w),
                  Text(
                    'Account Settings',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.check_box_outlined),
                  SizedBox(width: 20.w),
                  Text(
                    'Request Verification',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.mode_edit_outline),
                  SizedBox(width: 20.w),
                  Text(
                    'Edit Profile',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.north_east),
                  SizedBox(width: 20.w),
                  Text(
                    'Manage Outgoing Request',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Text(
                'General',
                style: TextStyle(
                  color: Color(0xFF929191),
                  fontSize: 12.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.language_outlined),
                  SizedBox(width: 20.w),
                  Text(
                    'Language',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Text(
                'Support',
                style: TextStyle(
                  color: Color(0xFF929191),
                  fontSize: 12.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.help_outline),
                  SizedBox(width: 20.w),
                  Text(
                    'Help',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.thumb_up_alt_outlined),
                  SizedBox(width: 20.w),
                  Text(
                    'Feedback',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.error_outline),
                  SizedBox(width: 20.w),
                  Text(
                    'Request a feature',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.share_outlined),
                  SizedBox(width: 20.w),
                  Text(
                    'Share this App',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.play_arrow_outlined),
                  SizedBox(width: 20.w),
                  Text(
                    'Rate on Google Play',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Text(
                'Legal',
                style: TextStyle(
                  color: Color(0xFF929191),
                  fontSize: 12.sp,
                  fontFamily: 'sf pro display',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.lock_outline),
                  SizedBox(width: 20.w),
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 20.h),
              child: Row(
                children: [
                  Icon(Icons.shield_outlined),
                  SizedBox(width: 20.w),
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      color: Color(0xFF000B17),
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Divider(),
            ),
            SizedBox(height: 30.h),
            GestureDetector(onTap: (){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Login()), (route)=>(false));},
              child: Center(
                child: Container(
                  width: 339.w,
                  height: 56.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFF000B17),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)),
                  ),
                  child: Center(
                    child: Text(
                      'Log Out',
                      style: GoogleFonts.inter(
                        textStyle: TextStyle(
                          color: Color(0xFFF7F5F2),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
