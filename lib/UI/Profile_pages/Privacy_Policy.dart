import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  final firestore =
  FirebaseFirestore.instance.collection("Privacy").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,

      body:  SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestore,
          builder: (Buildcontext, AsyncSnapshot<QuerySnapshot> snapshot) {
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
              padding:  EdgeInsets.only(left: 20.h),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 90.h),
                  Text(
                    snapshot.data!.docs[0]['Privacypolicy'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    snapshot.data!.docs[0]['Privacytext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h),Text(
                    snapshot.data!.docs[0]['Information'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),Text(
                    snapshot.data!.docs[0]['Informationtext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h),Text(
                    snapshot.data!.docs[0]['Informationdata'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),Text(
                    snapshot.data!.docs[0]['Informationdatatext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    snapshot.data!.docs[0]['Sharing'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    snapshot.data!.docs[0]['Sharingtext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h),Text(
                    snapshot.data!.docs[0]['Cookies'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),Text(
                    snapshot.data!.docs[0]['Cookiestext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    snapshot.data!.docs[0]['Security'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    snapshot.data!.docs[0]['Securitytext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Text(
                    snapshot.data!.docs[0]['Rights'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    snapshot.data!.docs[0]['Rightstext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h), Text(
                    snapshot.data!.docs[0]['Children’sPrivacy'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    snapshot.data!.docs[0]['Children’sPrivacytext'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 30.h), Text(
                    snapshot.data!.docs[0]['Changes'].toString(),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontFamily: 'sf pro display',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    snapshot.data!.docs[0]['Changestext'].toString(),
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
            );
          }else{return SizedBox();}}
        )
      ),
    );
  }
}
