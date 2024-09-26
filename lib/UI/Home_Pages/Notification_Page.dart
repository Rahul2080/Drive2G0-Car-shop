import 'package:drive2go/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    final message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;
    return Scaffold(
      backgroundColor: Colors.black,
      body: message == null
          ? SizedBox()
          : Column(
              children: [
                ListView.separated(
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
                )
              ],
            ),
    );
  }
}
