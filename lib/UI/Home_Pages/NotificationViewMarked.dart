
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationViewMarked extends StatefulWidget {
  final String tittle;
  final String discription;

  const NotificationViewMarked({super.key, required this.tittle, required this.discription,});

  @override
  State<NotificationViewMarked> createState() => _NotificationViewMarkedState();
}

class _NotificationViewMarkedState extends State<NotificationViewMarked> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30.h),
          Container(width: double.infinity.w,height:300.h,
          child: Image.asset('assets/notificationViewimage.png'),
          ),
          Text(
            widget.tittle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF7F5F2),
              fontSize: 22.sp,
              fontFamily: 'sf pro display',
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 20.h),
          Text(
            widget.discription,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFFF7F5F2),
              fontSize: 22.sp,
              fontFamily: 'sf pro display',
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
