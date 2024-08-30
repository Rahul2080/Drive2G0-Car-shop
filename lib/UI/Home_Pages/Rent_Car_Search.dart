import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RentCarSearch extends StatefulWidget {

  const RentCarSearch({super.key});

  @override
  State<RentCarSearch> createState() => _RentCarSearchState();
}

class _RentCarSearchState extends State<RentCarSearch> {
  TextEditingController rentCarSearchcontroller=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(onTap: (){Navigator.of(context).pop();},
            child: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: Container(
                width: 345.w,
                height: 48.h,
                decoration: ShapeDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(8, -0.54),
                    end: Alignment.topCenter,
                    colors: [Colors.white, Colors.white.withOpacity(0)],
                  ),
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1.w, color: Color(0xFF58606A)),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: TextField(controller: rentCarSearchcontroller,
                  style: TextStyle(color: Colors.white),
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                      hintText: 'What are you looking for..',
                      hintStyle: TextStyle(
                        color: Color(0xFF627387),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 10.h, horizontal: 15.w),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      border: InputBorder.none),
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity.w,
              height: 780.h,
              child: GridView.count(
                childAspectRatio: 400 / 450,
                mainAxisSpacing: 20.h,
                crossAxisCount: 2,
                shrinkWrap: true,
                children: List.generate(
                  20,
                  (index) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10.w, right: 10.h),
                      child: Container(
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(7, -0.54),
                            end: Alignment(-0.84, 0.54),
                            colors: [Colors.white, Colors.white.withOpacity(0)],
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1.w, color: Color(0xFF58606A)),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(2.sp),
                              child: SizedBox(
                                  child: Image.asset("assets/car.png")),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 5.h),
                              child: Text(
                                'Audi R8 Coupé',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFF7F5F2),
                                  fontSize: 16.sp,
                                  fontFamily: 'sf pro display',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 5.w,),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Color(0xFFF7F5F2),
                                    size: 20.sp,
                                  ),
                                  Text(
                                    'Kottakal',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFF7F5F2),
                                      fontSize: 14.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w300,
                                      letterSpacing: 0.50.w,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10.w, top: 5.h),
                              child: Text(
                                '\$ 8000 / day',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFFFFD66D),
                                  fontSize: 13.sp,
                                  fontFamily: 'SF Pro Display',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.50.w,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
