import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HelpChatPage extends StatefulWidget {
  const HelpChatPage({super.key});

  @override
  State<HelpChatPage> createState() => _HelpChatPageState();
}

class _HelpChatPageState extends State<HelpChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomSheet: Container(
        width: double.infinity.w,
        height: 80.h,
        color: Colors.black,

        child: TextField(cursorColor: Colors.white,
          style:
          TextStyle(color: Colors.white),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: Color(0xFF627487),
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.w,
                  color: Color(0xFF627487),
                )),
            hintText: "Phone Number",
            hintStyle: TextStyle(
                color: Color(0xFFA7B0BB),
                fontSize: 16.sp),
            filled: true,
            fillColor: Colors.black,
            focusColor: Colors.white
                .withOpacity(
                0.18000000715255737),
            border: OutlineInputBorder(
                borderRadius:
                BorderRadius.circular(
                    10.r),
                borderSide:
                BorderSide(width: 1.w)),
          ),),
      ),
    );
  }
}
