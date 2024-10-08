import 'package:drive2go/Bloc/MyOrderBuyVehicles_Bloc/my_order_buy_vehicles_bloc.dart';
import 'package:drive2go/Bloc/MyRentVehicles_Bloc/my_rent_vehicles_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../Repository/ModelClass/BuyvehiclesModels/MyOrderBuyVehiclesModel.dart';
import '../Repository/ModelClass/RentVehiclesModels/MyRentVehiclesModel.dart';

class MyCars extends StatefulWidget {
  const MyCars({super.key});

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  late List<MyRentVehiclesModel> myrentvehicles;
late List<MyOrderBuyVehiclesModel>myorderbuyvehicles;
  @override
  void initState() {
    BlocProvider.of<MyRentVehiclesBloc>(context).add(FeatchMyRentVehicles());
    BlocProvider.of<MyOrderBuyVehiclesBloc>(context).add(FeatchMyOrderBuyVehicles());
    super.initState();
  }

  String dateConvert(String iso) {
    String isoString = iso;

    // Convert ISO string to DateTime
    DateTime dateTime = DateTime.parse(isoString);

    // Format DateTime to a specific format
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    print(formattedDate);
    return formattedDate; // Output: 2024-09-03 – 14:30
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              height: 50.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: Colors.black),
              child: TabBar(indicatorColor: Colors.white,
                dividerColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.tab,
                labelColor: Colors.black12,
                // ignore: prefer_const_literals_to_create_immutables
                tabs: [
                  Tab(
                    icon: Text(
                      "Rental Cars", style: TextStyle(color: Colors.white),),
                  ),
                  Tab(
                      icon: Text(
                          "My Cars", style: TextStyle(color: Colors.white))
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: BlocBuilder<MyRentVehiclesBloc, MyRentVehiclesState>(
                      builder: (context, state) {
                        if (state is MyRentVehiclesBlocLoading) {
                          return Center(child: CircularProgressIndicator(),);
                        }
                        if (state is MyRentVehiclesBlocError) {
                          return Center(child: Text(
                            "Error", style: TextStyle(color: Colors.white),),);
                        }
                        if (state is MyRentVehiclesBlocLoaded) {
                          myrentvehicles = BlocProvider
                              .of<MyRentVehiclesBloc>(context)
                              .myrentvehicles;

                          return ListView.separated(
                            itemCount: myrentvehicles.length,
                            itemBuilder: (context, position) {
                              String pickeddate = dateConvert(
                                myrentvehicles[position].pickupDate
                                    .toString(),);
                              String Returndate = dateConvert(
                                  myrentvehicles[position].returnDate
                                      .toString());
                              return Padding(
                                padding: EdgeInsets.only(
                                    left: 10.w, top: 10.h, right: 10.w),
                                child: Container(
                                  width: 391.w,
                                  height: 129.h,
                                  decoration: ShapeDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(8, -0.54),
                                      end: Alignment(-0.84, 0.54),
                                      colors: [
                                        Colors.white,
                                        Colors.white.withOpacity(0)
                                      ],
                                    ),
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(width: 1.w,
                                          color: Color(0xFF58606A)),
                                      borderRadius: BorderRadius.circular(
                                          10.r),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .start,
                                    children: [
                                      SizedBox(width: 5.w,),
                                      Container(
                                        width: 134.w,
                                        height: 121.h,
                                        decoration: ShapeDecoration(
                                          color: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius
                                                  .circular(6.r)),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              6.r),
                                          child: Image.network(
                                            myrentvehicles[position].vehicle!
                                                .photos![0],
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 16.w),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment
                                            .start,
                                        children: [
                                          SizedBox(height: 10.h),
                                          Text(
                                            myrentvehicles[position].vehicle!
                                                .brand.toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Color(0xFFF7F5F2),
                                              fontSize: 16.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            myrentvehicles[position].vehicle!
                                                .ownerName.toString(),
                                            style: TextStyle(
                                              color: Color(0xFFF7F5F2),
                                              fontSize: 15.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 2.h),
                                          Text(
                                            pickeddate,
                                            style: TextStyle(
                                              color: Color(0xFFF7F5F2),
                                              fontSize: 12.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            Returndate,
                                            style: TextStyle(
                                              color: Color(0xFFF7F5F2),
                                              fontSize: 12.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Text(
                                            "${myrentvehicles[position]
                                                .vehicle!.mileage
                                                .toString()} Milage",
                                            style: TextStyle(
                                              color: Color(0xFFF7F5F2),
                                              fontSize: 12.sp,
                                              fontFamily: 'sf pro display',
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            top: 90.h, left: 60.w),
                                        child: Text(
                                          ' \₹ ${myrentvehicles[position]
                                              .vehicle!.rentPrice
                                              .toString()}/Day',
                                          style: TextStyle(
                                            color: Color(0xFFFFD66D),
                                            fontSize: 16.sp,
                                            fontFamily: 'sf pro display',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                            separatorBuilder: (context, position) {
                              return SizedBox(height: 5.h,);
                            },
                          );
                        } else {
                          return SizedBox();
                        }
                      }
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.black,
                  child: BlocBuilder<MyOrderBuyVehiclesBloc, MyOrderBuyVehiclesState>(
  builder: (context, state) {
    if(state is MyOrderBuyVehiclesBlocLoading){ return Center(child: CircularProgressIndicator(),);}
    if(state is MyOrderBuyVehiclesBlocError){ return Center( child: Text("Error",style: TextStyle(color: Colors.white),),);}
    if(state is MyOrderBuyVehiclesBlocLoaded){
     myorderbuyvehicles=BlocProvider.of< MyOrderBuyVehiclesBloc>(context).myorderbuyvehicles;

    return ListView.separated(
                    itemCount: myorderbuyvehicles.length,

                    itemBuilder: (context, position) {
                      String pickeddate = dateConvert(
                        myorderbuyvehicles[position].purchaseDate
                            .toString(),);
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 10.w, top: 10.h, right: 10.w),
                        child:  myorderbuyvehicles[position].vehicle==null?SizedBox():Container(
                          width: 391.w,
                          height: 129.h,
                          decoration: ShapeDecoration(
                            gradient: LinearGradient(
                              begin: Alignment(8, -0.54),
                              end: Alignment(-0.84, 0.54),
                              colors: [
                                Colors.white,
                                Colors.white.withOpacity(0)
                              ],
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  width: 1.w, color: Color(0xFF58606A)),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                          ),
                          child: Row(mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 5.w,),
                              Container(
                                width: 134.w,
                                height: 121.h,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(6.r)),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6.r),
                                  child: Image.network(
                                   myorderbuyvehicles[position].vehicle!.photos![0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  Text(
                                    myorderbuyvehicles[position].vehicle!.brand.toString(),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFFF7F5F2),
                                      fontSize: 16.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                    myorderbuyvehicles[position].vehicle!.ownerName.toString(),
                                    style: TextStyle(
                                      color: Color(0xFFF7F5F2),
                                      fontSize: 15.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                  pickeddate,
                                    style: TextStyle(
                                      color: Color(0xFFF7F5F2),
                                      fontSize: 12.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(height: 8.h),
                                  Text(
                                  "  ${myorderbuyvehicles[position].vehicle!.mileage.toString()} \Milage",
                                    style: TextStyle(
                                      color: Color(0xFFF7F5F2),
                                      fontSize: 12.sp,
                                      fontFamily: 'sf pro display',
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 50.w, top: 90.h),
                                child: Text(
                                 " ${myorderbuyvehicles[position].vehicle!.rentPrice.toString()}",
                                  style: TextStyle(
                                    color: Color(0xFFFFD66D),
                                    fontSize: 16.sp,
                                    fontFamily: 'sf pro display',
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, position) {
                      return SizedBox(height: 5.h,);
                    },
                  );
  } else {return SizedBox();}}
),
                ),
              ]),
            ),
            SizedBox(height: 60.h,)
          ],
        ),
      ),
    );
  }
}
