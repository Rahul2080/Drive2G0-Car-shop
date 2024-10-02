import 'package:drive2go/Bloc/Feedback_Bloc/feedback_bloc.dart';
import 'package:drive2go/Repository/ModelClass/ProfileModels/FeedbackModel/FeedbackModel.dart';
import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../ToastMessage.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  TextEditingController feedbackcontroller = TextEditingController();
  late FeedbackModel feedback;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 30.w),
              child: TextField(
                maxLines: 14,
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
                      borderRadius: BorderRadius.circular(5.r),
                      borderSide: BorderSide.none),
                ),
              ),
            ),
          ),
          SizedBox(height: 50.h),
          BlocListener<FeedbackBloc, FeedbackState>(
            listener: (context, state) {
              if (state is FeedbackBlocLoading) {
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
              if (state is FeedbackBlocError) {
                Navigator.of(context).pop();

                print('error');
              }
              if (state is FeedbackBlocLoaded) {
                Navigator.of(context).pop();
                feedback = BlocProvider.of<FeedbackBloc>(context).feedbackModel;
                feedbackcontroller.clear();
                ToastMessage().toastmessage(message: " Feedback Uploded Succesfully ");
              }
            },
            child: InkWell(
              onTap: () {

                BlocProvider.of<FeedbackBloc>(context)
                    .add(FeatchFeedback(comment: feedbackcontroller.text));

              },
              child: Container(
                width: 200.w,
                height: 60.h,
                decoration: ShapeDecoration(
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 25.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
