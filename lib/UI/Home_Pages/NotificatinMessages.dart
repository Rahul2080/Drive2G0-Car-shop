import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificatinMessages extends StatefulWidget {
  const NotificatinMessages({super.key});

  @override
  State<NotificatinMessages> createState() => _NotificatinMessagesState();
}

class _NotificatinMessagesState extends State<NotificatinMessages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body:  Center(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            SizedBox(width: 400.w,height: 900.h,
              child: ListView.separated(
                itemCount: 20,
                itemBuilder: (context, position) {
                
                  return Container(
                    width: 190.w,height: 90.h,
                    decoration: ShapeDecoration(color:Colors.white24,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.r),),),
                    child: Text('data'),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    height: 5.h,
                  );
                },
              ),
            )

          ],
        ),
      ),

    );
  }
}
