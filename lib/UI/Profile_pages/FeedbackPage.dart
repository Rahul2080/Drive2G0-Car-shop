import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {

  TextEditingController feedbackcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
          padding:  EdgeInsets.only(left: 20.w,right: 30.w),
          child: TextField(
            controller: feedbackcontroller,
            cursorColor: Colors.white,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Type your Feedback",
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
      ),
    );
  }
}
