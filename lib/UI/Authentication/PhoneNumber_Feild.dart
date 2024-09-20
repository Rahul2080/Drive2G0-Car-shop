import 'package:drive2go/UI/BottomNavigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Bloc/Siginup_Bloc/signup_bloc.dart';

class PhonenumberFeild extends StatefulWidget {
  final String username;
  final String useremail;
  final String password;
  const PhonenumberFeild({super.key, required this.username, required this.useremail, required this.password});

  @override
  State<PhonenumberFeild> createState() => _PhonenumberFeildState();
}

class _PhonenumberFeildState extends State<PhonenumberFeild> {
  TextEditingController phonenumbercontroller = TextEditingController();

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
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 10.h),
              child: TextFormField(
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
                validator: (phonenumber) {
                  if (phonenumber!.isEmpty || phonenumber.length < 10) {
                    return 'enter 10 digit number';
                  }

                  return null;
                },
              ),
            ),
            SizedBox(height: 30.h),
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
                      MaterialPageRoute(builder: (_) => Bottomnavigation()),
                          (route) => (false));
                }
                if (state is userBlocError) {
                  Navigator.of(context).pop();
                  print('error');
                }
              },
              child: GestureDetector(onTap: () {
                BlocProvider.of<SignupBloc>(context).add(FeatchUser(name:widget.username,
                    email: widget.useremail,
                    phonenumber: phonenumbercontroller.text,
                    password: widget.password));
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
            )
          ],
        ),
      ),
    );
  }
}
