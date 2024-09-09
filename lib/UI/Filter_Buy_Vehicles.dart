import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FilterBuyVehicles extends StatefulWidget {
  const FilterBuyVehicles({super.key});

  @override
  State<FilterBuyVehicles> createState() => _FilterBuyVehiclesState();
}

class _FilterBuyVehiclesState extends State<FilterBuyVehicles> {
  List<String> text = [
    'brand',
    'price',
    'geartype',
    'fueltype',
    'noofset',
    'color'
  ];

  List<String> result = [
    'ldnlzgnnl',
    'pmdzlvkmrice',
    'gemjjkoartype',
    'fueltypfxfhrhe',
    'noofsetbffh',
    'coloopdzgkpir'
  ];

  int selectedIndex = 0;
  Map<int, bool> checkboxValues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150.w,
                      height: 920.h,
                      child: ListView.separated(
                        itemCount: text.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, position) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                selectedIndex = position;
                              });
                            },
                            child: Container(
                              color: selectedIndex == position
                                  ? Colors.black
                                  : Colors.grey[300],
                              width: 100.w,
                              height: 40.h,
                              alignment: Alignment.center,
                              child: Center(
                                child: Text(
                                  text[position],
                                  style: TextStyle(
                                    color: selectedIndex ==position?Colors.white: Colors.black,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(height: 10.h);
                        },
                      ),
                    ),

                    Expanded(
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: selectedIndex != -1
                            ? Container(
                                key: ValueKey<int>(selectedIndex),
                                width: 260.w,
                                height: 900.h,
                                decoration: ShapeDecoration(   gradient: LinearGradient(
                                  begin: Alignment(3, 0.54),
                                  end: Alignment(-0.34, 0.54),
                                  colors: [Colors.white, Colors.white.withOpacity(0)],
                                ),
                                    shape: RoundedRectangleBorder()),
                                child: ListView.builder(
                                  itemCount: result.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Checkbox(
                                            value:
                                                checkboxValues[index] ?? false,
                                            onChanged: (value) {
                                              setState(() {
                                                checkboxValues[index] = value!;
                                              });
                                            },
                                          ),
                                          SizedBox(width: 10.w),
                                          Text(
                                            result[index],
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              )
                            : const SizedBox(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 860.h),
              child: Container(
                width: 430.w,
                height: 99.h,
                decoration: ShapeDecoration(
                  color: Colors.white.withOpacity(0.7344567788),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16.r),
                      topRight: Radius.circular(16.r),
                    ),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Row(
                    children: [
                      Container(
                        width: 100.w,
                        height: 50.h,
                        decoration: ShapeDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Color(0xFFFFF0C9),
                              Color(0xFFFFCE50),
                              Color(0xFFD39906),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Apply',
                            style: TextStyle(
                              color: Color(0xFFF7F5F2),
                              fontSize: 20.sp,
                              fontFamily: 'sf pro display',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
