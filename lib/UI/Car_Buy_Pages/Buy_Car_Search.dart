import 'package:drive2go/Bloc/SearchBuyVehicles_Bloc/search_buy_vehicles_bloc.dart';
import 'package:drive2go/UI/Car_Buy_Pages/CarBuy_Details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

import '../../Repository/ModelClass/SearchBuyVehiclesModel.dart';

class BuyCarSearch extends StatefulWidget {
  const BuyCarSearch({super.key});

  @override
  State<BuyCarSearch> createState() => _BuyCarSearchState();
}

class _BuyCarSearchState extends State<BuyCarSearch> {
  TextEditingController buyCarSearchcontroller = TextEditingController();
  late List<SearchBuyVehiclesModel> searchbuyvechiles;
  List<String> places = [];

  Future<List<Placemark>> _getVechileAddress(String lat, String long) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        double.parse(lat),
        double.parse(long),
      );

      return placemarks; // Return the list of placemarks instead of a single placemark
    } catch (e) {
      print(e);
      return []; // Return an empty list in case of an error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        backgroundColor: Colors.black,
      ),
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
                child: TextField(
                  controller: buyCarSearchcontroller,
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
                  onChanged: (value) {
                    BlocProvider.of<SearchBuyVehiclesBloc>(context).add(
                        FeatchSearchBuyVehicles(
                            brandname: buyCarSearchcontroller.text));
                  },
                  onSubmitted: (value) {
                    BlocProvider.of<SearchBuyVehiclesBloc>(context).add(
                        FeatchSearchBuyVehicles(
                            brandname: buyCarSearchcontroller.text));
                  },
                ),
              ),
            ),
            SizedBox(height: 30.h),
            SizedBox(
              width: double.infinity.w,
              child: BlocBuilder<SearchBuyVehiclesBloc, SearchBuyVehiclesState>(
                  builder: (context, state) {
                    if (state is SearchBuyVehiclesBlocLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is SearchBuyVehiclesBlocError) {
                      return Center(
                        child: Text(
                          ' Error',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }

                    if (state is SearchBuyVehiclesBlocLoaded) {
                      searchbuyvechiles =
                          BlocProvider
                              .of<SearchBuyVehiclesBloc>(context)
                              .searchbuyvehicles;
                      return buyCarSearchcontroller.text.isNotEmpty
                          ? GridView.count(
                        childAspectRatio: 400 / 420,
                        mainAxisSpacing: 20.h,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: List.generate(
                          searchbuyvechiles.length,
                              (index) {
                            return FutureBuilder(
                                future: _getVechileAddress(
                                    searchbuyvechiles[index]
                                        .location!
                                        .coordinates!
                                        .first
                                        .toString(),
                                    searchbuyvechiles[index]
                                        .location!
                                        .coordinates!
                                        .last
                                        .toString()),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(
                                        child:
                                        Text("Error fetching location"));
                                  } else if (snapshot.hasData) {
                                    String? place =
                                        snapshot.data![0].locality;
                                    places.add(place ?? "");
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          left: 10.w, right: 10.w),
                                      child: GestureDetector(onTap: () {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(builder: (_) =>
                                                CarbuyDetails(
                                                    carimage: searchbuyvechiles[index].photos!,
                                                    carname: searchbuyvechiles[index].brand.toString(),
                                                    ratting: searchbuyvechiles[index].rating.toString(),
                                                    tanktype: searchbuyvechiles[index].fuelType.toString(),
                                                    geartype: searchbuyvechiles[index].gearType.toString(),
                                                    seat: searchbuyvechiles[index].noOfSeats.toString(),
                                                    door: searchbuyvechiles[index].noOfDoors.toString(),
                                                    Ownerimge: searchbuyvechiles[index].ownerProfilePhoto.toString(),
                                                    Ownername: searchbuyvechiles[index].ownerName.toString(),
                                                    Ownerplace: searchbuyvechiles[index].ownerPlace.toString(),
                                                    carplace: place,
                                                    places: places,
                                                    price: searchbuyvechiles[index].rentPrice.toString(),
                                                    id: searchbuyvechiles[index].id
                                                .toString(), ownernumber:searchbuyvechiles[index].ownerPhoneNumber.toString(),)));
                                      },
                                        child: Container(
                                          decoration: ShapeDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment(7, -0.54),
                                              end: Alignment(-0.84, 0.54),
                                              colors: [
                                                Colors.white,
                                                Colors.white.withOpacity(0)
                                              ],
                                            ),
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                  width: 1.w,
                                                  color: Color(0xFF58606A)),
                                              borderRadius:
                                              BorderRadius.circular(10.r),
                                            ),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: EdgeInsets.all(2.sp),
                                                child: Container(
                                                  width: double.infinity.w,
                                                  height: 140.h,
                                                  child: ClipRRect(
                                                    borderRadius: BorderRadius
                                                        .only(
                                                        topRight:
                                                        Radius.circular(
                                                            10.r),
                                                        topLeft:
                                                        Radius.circular(
                                                            10.r)),
                                                    child: Image.network(
                                                      searchbuyvechiles[index]
                                                          .photos![0],
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.w, top: 5.h),
                                                child: Text(
                                                  searchbuyvechiles[index]
                                                      .brand
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFF7F5F2),
                                                    fontSize: 16.sp,
                                                    fontFamily:
                                                    'sf pro display',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                  left: 5.w,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      Icons
                                                          .location_on_outlined,
                                                      color: Color(0xFFF7F5F2),
                                                      size: 20.sp,
                                                    ),
                                                    Text(
                                                      place!,
                                                      textAlign:
                                                      TextAlign.center,
                                                      style: TextStyle(
                                                        color:
                                                        Color(0xFFF7F5F2),
                                                        fontSize: 14.sp,
                                                        fontFamily:
                                                        'sf pro display',
                                                        fontWeight:
                                                        FontWeight.w300,
                                                        letterSpacing: 0.50.w,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.only(
                                                    left: 10.w, top: 5.h),
                                                child: Text(
                                                  ' \₹ ${searchbuyvechiles[index]
                                                      .rentPrice.toString()}',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Color(0xFFFFD66D),
                                                    fontSize: 13.sp,
                                                    fontFamily:
                                                    'SF Pro Display',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.50.w,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return SizedBox();
                                  }
                                });
                          },
                        ),
                      )
                          : SizedBox();
                    } else {
                      return SizedBox();
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
