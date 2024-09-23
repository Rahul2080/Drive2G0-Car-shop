import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Termsandconditions extends StatefulWidget {
  const Termsandconditions({super.key});

  @override
  State<Termsandconditions> createState() => _TermsandconditionsState();
}

class _TermsandconditionsState extends State<Termsandconditions> {
  final firestore =
  FirebaseFirestore.instance.collection("TermsAndConditions").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
      body:Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore,
          builder: (Buildcontext,AsyncSnapshot<QuerySnapshot> snapshot   ) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              Navigator.of(context).pop();
              return Center(
                child: Text(
                  "ERROR",
                  style: TextStyle(color: Colors.red),
                ),
              );
            }
            if (snapshot.hasData) {
              return Padding(
                padding:  EdgeInsets.only(left: 20.w),
                child: SingleChildScrollView(scrollDirection: Axis.vertical,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 90.h),
                      Text(
                        snapshot.data!.docs[0]['Terms'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        snapshot.data!.docs[0]['Termstext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h),Text(
                        snapshot.data!.docs[0]['Services'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),Text(
                        snapshot.data!.docs[0]['Servicestext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h),Text(
                        snapshot.data!.docs[0]['Rentals'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),Text(
                        snapshot.data!.docs[0]['Rentalstext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        snapshot.data!.docs[0]['Purchases'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        snapshot.data!.docs[0]['Purchasestext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h),Text(
                        snapshot.data!.docs[0]['Eligibility'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),Text(
                        snapshot.data!.docs[0]['Eligibilitytext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        snapshot.data!.docs[0]['Cancellation'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        snapshot.data!.docs[0]['Cancellationtext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h),
                      Text(
                        snapshot.data!.docs[0]['Payment'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        snapshot.data!.docs[0]['Paymenttext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h), Text(
                        snapshot.data!.docs[0]['Third-Party'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        snapshot.data!.docs[0]['Third-Partytext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h), Text(
                        snapshot.data!.docs[0]['Contact'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        snapshot.data!.docs[0]['Contacttext'].toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontFamily: 'sf pro display',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 30.h),
                    ],
                  ),
                ),
              );
            }
          else return SizedBox();})
      ),
    );
  }
}
