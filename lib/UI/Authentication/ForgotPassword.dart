import 'package:drive2go/Bloc/ForgotPassword_Bloc/forgot_password_bloc.dart';
import 'package:drive2go/Repository/ModelClass/AuthenticationModels/ForgotPasswordModel.dart';
import 'package:drive2go/UI/Authentication/NewPassword.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

class Forgotpassword extends StatefulWidget {
  const Forgotpassword({super.key});

  @override
  State<Forgotpassword> createState() => _ForgotpasswordState();
}

class _ForgotpasswordState extends State<Forgotpassword> {
  TextEditingController emailcontroller = TextEditingController();
  var formkey = GlobalKey<FormState>();

  late ForgotPasswordModel forgotPassword;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key:formkey ,
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
          ), child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 50.h),
              child: TextFormField(
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
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.r),
                      borderSide: BorderSide.none),
                ),
                validator: (emailvalue) {
                  if (emailvalue!.isEmpty ||
                      !RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(emailvalue)) {
                    return 'Enter a valid email!';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 40.h,),
            BlocListener<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
        if (state is ForgotPasswordBlocLoading) {
          print("siginloading");

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );
        }
        if (state is ForgotPasswordBlocError) {
          Navigator.of(context).pop();


          print('error');
        }
        if (state is ForgotPasswordBlocLoaded) {
          Navigator.of(context).pop();
        forgotPassword=BlocProvider.of<ForgotPasswordBloc>(context).forgotPasswordModel;
          Navigator.of(context).push(MaterialPageRoute(builder: (_)=>NewPassword()));
              }},
              child: GestureDetector(
                onTap: () {
            final isValid = formkey.currentState?.validate();
            if (isValid!) {
        BlocProvider.of<ForgotPasswordBloc>(context).add(
            FeatchForgotPassword(email: emailcontroller.text));
        emailcontroller.clear();
            }
            formkey.currentState?.save();

                },
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
                      'Sumbit',
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
          ],
        ),
        ),
      ),
    );
  }
}
