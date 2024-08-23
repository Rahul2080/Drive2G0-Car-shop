import 'package:drive2go/Home.dart';
import 'package:drive2go/Login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'BottomNavigation.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController phonenumbercontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();


  bool passwordvisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(-0.09.w, 1.00.h),
            end: Alignment(0.09.w, -1.h),
            colors: [
              Colors.black,
              Color(0xFF272C2F),
              Color(0xFF525E64),
              Color(0xFF3B4F58),
              Color(0xFF01293B)
            ],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 147.h),
                child: Text(
                  'Create New Account',
                  style: TextStyle(
                    color: Color(0xFFF6F6F6),
                    fontSize: 28.sp,
                    fontFamily: 'sf pro display',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.70.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 80.h),
                child: TextField(
                  controller: namecontroller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    hintStyle:
                    TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 10.h),
                child: TextField(
                  controller: emailcontroller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Email Address",
                    hintStyle:
                    TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 10.h),
                child: TextField(
                  controller: phonenumbercontroller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Phone Number",
                    hintStyle:
                    TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 10.h),
                child: TextField(
                  controller: passwordcontroller,
                  obscureText: passwordvisible,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle:
                    TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    suffixIcon: IconButton(
                        icon: passwordvisible == false ? Icon(
                          Icons.visibility, color: Color(0xFFA7B0BB),): Icon(
                          Icons.visibility_off_outlined,
                          color: Color(0xFFA7B0BB),
                        ),
                        onPressed: () {
                          setState(() {
                            passwordvisible = !passwordvisible;
                          });
                        }),
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),

              GestureDetector(onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => Bottomnavigation()),(route)=>(false));
              },
                child: Container(
                  width: 350.w,
                  height: 73.h,
                  decoration: ShapeDecoration(
                    color: Color(0xFFDDE0E3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ), child: Center(
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Color(0xFF01293B),
                      fontSize: 22.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.20.w,
                    ),
                  ),
                ),
                ),
              ),
              SizedBox(height: 30.h),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Have an account?',
                    style: TextStyle(
                      color: Color(0xFFDDE0E3),
                      fontSize: 16.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  GestureDetector(onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => Login()));
                  },
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xFF0078FF),
                        fontSize: 16.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  )
                ],
              )

            ],
          ),
        ),
      ),
    );
  }
}
