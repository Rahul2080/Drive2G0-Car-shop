import 'package:drive2go/BottomNavigation.dart';
import 'package:drive2go/Home_Pages/Home.dart';
import 'package:drive2go/Authentication/IntroPage.dart';
import 'package:drive2go/Authentication/Signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool passwordvisible = true;

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
                padding: EdgeInsets.only(top: 149.h),
                child: Text(
                  'Welcome ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFFF6F6F6),
                    fontSize: 32.sp,
                    fontFamily: 'sf pro display',
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.80.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 50.h),
                child: TextField(
                  controller: emailcontroller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle:
                        TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),

                    border:OutlineInputBorder(borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 35.w),
                child: TextField(
                  controller: passwordcontroller,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  autocorrect: true,
                  obscureText: passwordvisible,
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle:
                        TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),

                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.r),
                       borderSide: BorderSide.none),
                    suffixIcon: IconButton(
                      icon:passwordvisible==false? Icon(
                        Icons.visibility,
                        color: Color(0xFFA7B0BB),
                      ):Icon(
                        Icons.visibility_off_outlined,
                        color: Color(0xFFA7B0BB),
                      ) ,
                      onPressed: () {
                        setState(() {
                          passwordvisible = !passwordvisible;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 230.w, top: 10.h),
                child: Container(
                  width: 160.w,
                  height: 26.h,
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      color: Color(0xFFDDE0E3),
                      fontSize: 16.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 73.h),
                child: GestureDetector(onTap:  (){Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=>Bottomnavigation()),(route)=>(false));},
                  child: Container(
                    width: 350.w,
                    height: 73.h,
                    decoration: ShapeDecoration(
                      color: Color(0xFFDDE0E3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: Color(0xFF01293B),
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.20.w,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 350.w,
                height: 73.h,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                        width: 60.w,
                        height: 40.h,
                        child: Image.asset("assets/google.png")),

                    Text(
                      'Sign In With Google',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontFamily: 'sf pro display',
                        fontWeight: FontWeight.w400,

                        letterSpacing: 0.16.w,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 80.h),

              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account',
                    style: TextStyle(
                      color: Color(0xFFDDE0E3),
                      fontSize: 16.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w400,
                    ),
                  ),SizedBox(width: 10.w),
                  GestureDetector(onTap: (){ Navigator.of(context).push(MaterialPageRoute(builder: (_)=>Signup()));},
                    child: Text(
                      'Sign Up',
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
