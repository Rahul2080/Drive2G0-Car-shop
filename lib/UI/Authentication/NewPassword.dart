import 'package:drive2go/Bloc/UserByUserIdForgotPassword_Bloc/userby_user_id_forgot_password_bloc.dart';
import 'package:drive2go/Repository/ModelClass/AuthenticationModels/UserbyUserIdPasswordModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NewPassword extends StatefulWidget {
  const NewPassword({super.key});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  TextEditingController newpassword = TextEditingController();
  TextEditingController conformnewpassword = TextEditingController();
  late UserbyUserIdPasswordModel userbyUserIdPassword;
@override
  void initState() {

BlocProvider.of<UserbyUserIdForgotPasswordBloc>(context).add(FeatchUserbyUserIdForgotPassword());
    super.initState();
  }
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
              Color(0xFF01293B),
            ],
          ),
        ),
        child: BlocListener<UserbyUserIdForgotPasswordBloc, UserbyUserIdForgotPasswordState>(
          listener: (context, state) {
    if (state is UserbyUserIdForgotPasswordBlocLoading) {
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
    if (state is UserbyUserIdForgotPasswordBlocError) {
    Navigator.of(context).pop();


    print('error');
    }
    if (state is UserbyUserIdForgotPasswordBlocLoaded) {


      userbyUserIdPassword=BlocProvider.of<UserbyUserIdForgotPasswordBloc>(context).userbyUserIdPasswordModel;


    }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 30.w,
                  right: 35.w,
                ),
                child: TextFormField(
                  controller: newpassword,
                  textInputAction: TextInputAction.next,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "New Password",
                    hintStyle:
                    TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (password) {
                    if (password!.isEmpty || password.length < 9) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w, right: 35.w, top: 20.h),
                child: TextFormField(
                  controller: conformnewpassword,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Conform Password",
                    hintStyle:
                    TextStyle(color: Color(0xFFA7B0BB), fontSize: 20.sp),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.18000000715255737),
                    focusColor: Colors.white.withOpacity(0.18000000715255737),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        borderSide: BorderSide.none),
                  ),
                  validator: (password) {
                    if (password!.isEmpty ||
                        password.length < 9 ||
                        newpassword != conformnewpassword) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(height: 30.h),
              Container(
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
            ],
          ),
        ),
      ),
    );
  }
}
