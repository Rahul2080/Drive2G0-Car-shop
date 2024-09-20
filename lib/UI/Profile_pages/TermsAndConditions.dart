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
              return SingleChildScrollView(
                child: Text(
                snapshot.data!.docs[0]['Terms'].toString(),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontFamily: 'sf pro display',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }
          else return SizedBox();})
      ),
    );
  }
}
