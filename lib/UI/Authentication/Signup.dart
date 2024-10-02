import 'package:drive2go/Bloc/Siginup_Bloc/signup_bloc.dart';
import 'package:drive2go/UI/Authentication/PhoneNumber_Feild.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'Login.dart';

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
  final GoogleSignIn googleSignIn = GoogleSignIn();
  FirebaseAuth auth = FirebaseAuth.instance;
  bool passwordvisible = true;
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(key: formkey,
        child: Container(
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
                  child: TextFormField(
                    controller: namecontroller,
                    cursorColor: Colors.white,
                    textInputAction: TextInputAction.next,
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
                    ),validator:(name){if (name!.isEmpty ){
                      return 'Enter your name';
                  }
                  return null;
                  } ,
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 10.h),
                  child: TextFormField(
                    controller: emailcontroller,
                    textInputAction: TextInputAction.next,
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
                    ),validator: (emailvalue){
                    if (emailvalue!.isEmpty ||
                        !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(emailvalue)) {
                      return 'Enter a valid email!';
                    }
                    return null;
                  },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 10.h),
                  child: TextFormField(
                    controller: phonenumbercontroller,
                    textInputAction: TextInputAction.next,
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
                    ),validator: (phonenumber) {
                    if (phonenumber!.isEmpty || phonenumber.length < 10) {
                      return 'enter 10 digit number';
                    }

                    return null;
                  },
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 10.h),
                  child: TextFormField(
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
                          icon: passwordvisible == false
                              ? Icon(
                                  Icons.visibility,
                                  color: Color(0xFFA7B0BB),
                                )
                              : Icon(
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
                    ),validator: (passwordvalue) {
                    if (passwordvalue!.isEmpty || passwordvalue.length < 9) {
                      return 'Enter a valid password!';
                    }

                    return null;
                  },
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                BlocListener<SignupBloc, SignupState>(
                  listener: (context, state) {
                    if (state is userBlocLoading) {
                      print("loading");

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Center(child: CircularProgressIndicator(),);
                        },
                      );
                    }
                    if (state is userBlocLoaded) {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => Login()),
                          (route) => (false));
                    }
                    if (state is userBlocError) {
                      Navigator.of(context).pop();
                      print('error');
                    }
                  },
                  child: GestureDetector(
                    onTap: () {final isValid = formkey.currentState?.validate();
    if (isValid!) {

                      BlocProvider.of<SignupBloc>(context).add(FeatchUser(
                          name: namecontroller.text,
                          email: emailcontroller.text,
                          phonenumber: phonenumbercontroller.text,
                          password: passwordcontroller.text));}
    formkey.currentState?.save();
                    },
                    child: Container(
                      width: 350.w,
                      height: 73.h,
                      decoration: ShapeDecoration(
                        color: Color(0xFFDDE0E3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25.r),
                        ),
                      ),
                      child: Center(
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
                ),SizedBox(height: 20.h),
                InkWell(onTap:signInwithGoogle ,
                  child: Container(
                    width: 350.w,
                    height: 73.h,
                    decoration: ShapeDecoration(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: 60.w,
                            height: 40.h,
                            child: Image.asset("assets/google.png")),
                        Text(
                          'Sign Up With Google',
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
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => Login()));
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
      ),
    );
  }
  Future<String?> signInwithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      // Getting users credential
      UserCredential result = await auth.signInWithCredential(credential);
      User? user = result.user;
      //
      // BlocProvider.of<SignupBloc>(context).add(FeatchUser(
      //     email: user?.email??"",
      //     password: user?.uid??"", name: user?.displayName??"", phonenumber: ""));
Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PhonenumberFeild(username: user!.displayName.toString(), useremail:user!.email.toString(), password:user!.uid,)));
      print("hellologin"+user!.email.toString()+ "username"+user!.displayName.toString()+user!.phoneNumber.toString()+user!.uid);
      // if result not null we simply call the MaterialpageRoute,
      // for go to the HomePage screen


    }catch (e) {

    }
  }

}
