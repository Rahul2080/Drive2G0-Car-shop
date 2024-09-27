import 'package:drive2go/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationViewMarked extends StatefulWidget {
  const NotificationViewMarked({super.key});

  @override
  State<NotificationViewMarked> createState() => _NotificationViewMarkedState();
}

class _NotificationViewMarkedState extends State<NotificationViewMarked> {
  @override
  Widget build(BuildContext context) {
    // final message =
    //     ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    return Scaffold(
      backgroundColor: Colors.white,
      body:Column(
              children: [
                SizedBox(
                  width: 100.w,height: 200.h,
                  child: ListView.separated(
                    itemCount: 6,
                    itemBuilder: (context, position) {
                      return Container(
                        width: 100.w,
                        height: 60.h,
                        decoration: ShapeDecoration(color:Colors.red,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.r),),),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 5.h,
                      );
                    },
                  ),
                ),
              ],
            ),
    );
  }
}
