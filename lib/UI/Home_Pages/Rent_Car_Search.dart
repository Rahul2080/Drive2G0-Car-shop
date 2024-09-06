import 'package:drive2go/Bloc/SearchRentVehicles_Bloc/search_rent_vehicles_bloc.dart';
import 'package:drive2go/UI/Home_Pages/car_Rent_details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';

import '../../Repository/ModelClass/SearchRentVehiclesModel.dart';

class RentCarSearch extends StatefulWidget {
  const RentCarSearch({super.key});

  @override
  State<RentCarSearch> createState() => _RentCarSearchState();
}

class _RentCarSearchState extends State<RentCarSearch> {
  TextEditingController rentCarSearchcontroller = TextEditingController();
  late List<SearchRentVehiclesModel> searchrentvehicles;
  List<String>places=[];

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
                child: TextField(
                  onChanged: (value) {
                    BlocProvider.of<SearchRentVehiclesBloc>(context).add(
                        FeatchSearchRentVehicles(
                            brandname: rentCarSearchcontroller.text));
                  },
                  onSubmitted: (value) {
                    BlocProvider.of<SearchRentVehiclesBloc>(context).add(
                        FeatchSearchRentVehicles(
                            brandname: rentCarSearchcontroller.text));
                  },
                  controller: rentCarSearchcontroller,
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
              child:
              BlocBuilder<SearchRentVehiclesBloc, SearchRentVehiclesState>(
                  builder: (context, state) {
                    if (state is SearchRentVehiclesBlocLoading) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (state is SearchRentVehiclesBlocError) {
                      return Center(
                        child: Text(
                          'Error',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    if (state is SearchRentVehiclesBlocLoaded) {
                      searchrentvehicles =
                          BlocProvider
                              .of<SearchRentVehiclesBloc>(context)
                              .searchrentvehicles;

                      return
                        rentCarSearchcontroller.text.isNotEmpty?
                        GridView.count(
                        childAspectRatio: 400 / 400,
                        mainAxisSpacing: 10.h,
                        crossAxisCount: 2,
                        shrinkWrap: true,
                        children: List.generate(
                            searchrentvehicles.length, (index) {
                          return Padding(
                            padding: EdgeInsets.only(left: 10.w, right: 10.h),
                            child: FutureBuilder(future:  _getVechileAddress(
    searchrentvehicles[index]
        .location!
        .coordinates!
        .first
        .toString(),
    searchrentvehicles[index]
        .location!
        .coordinates!
        .last
        .toString()) ,
                              builder:(context, snapshot) {
    if (snapshot.connectionState ==
    ConnectionState.waiting) {
    return Center(
    child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    return Center(
    child: Text("Error fetching location"));
    } else if (snapshot.hasData) {
    String? place = snapshot.data![0].locality;
    places.add(place??"");
    return GestureDetector(onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (_) => CarRentDetails(
                                        carimage:
                                        searchrentvehicles[
                                        index]
                                            .photos!,
                                        carname:
                                        searchrentvehicles[
                                        index]
                                            .brand
                                            .toString(),
                                        rating: searchrentvehicles[
                                        index]
                                            .rating
                                            .toString(),
                                        greartype:
                                        searchrentvehicles[
                                        index]
                                            .gearType
                                            .toString(),
                                        tanktype:
                                        searchrentvehicles[
                                        index]
                                            .fuelType
                                            .toString(),
                                        seats: searchrentvehicles[
                                        index]
                                            .noOfSeats
                                            .toString(),
                                        door: searchrentvehicles[
                                        index]
                                            .noOfDoors
                                            .toString(),
                                        carowner:
                                        searchrentvehicles[
                                        index]
                                            .ownerName
                                            .toString(),
                                        ownerplace:
                                        searchrentvehicles[
                                        index]
                                            .ownerPlace
                                            .toString(),
                                        carprice:
                                        searchrentvehicles[
                                        index]
                                            .rentPrice
                                            .toString(),
                                        carcolor:
                                        searchrentvehicles[
                                        index]
                                            .vehicleColor
                                            .toString(),
                                        availability:
                                        searchrentvehicles[
                                        index]
                                            .available!,
                                        id: searchrentvehicles[
                                        index]
                                            .id
                                            .toString(),
                                        vehicleid:
                                        searchrentvehicles[
                                        index]
                                            .id
                                            .toString(),
                                        ownerprofileimg:
                                        searchrentvehicles[
                                        index]
                                            .ownerProfilePhoto
                                            .toString(), carplace:places , place: place)));
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
                                          width: 1.w, color: Color(0xFF58606A)),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(2.sp),
                                        child: ClipRRect(
                                            borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(10.r),
                                                topRight: Radius.circular(10.r)),
                                            child: Image.network(
                                                searchrentvehicles[index]
                                                    .photos![0])),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(
                                            left: 10.w, top: 5.h),
                                        child: Text(
                                          searchrentvehicles[index].brand
                                              .toString(),
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
                                        padding: EdgeInsets.only(
                                          left: 5.w,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: Color(0xFFF7F5F2),
                                              size: 20.sp,
                                            ),
                                            Text(
                                              place!,
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
                                        padding: EdgeInsets.only(
                                            left: 10.w, top: 5.h),
                                        child: Text(
                                          ' \₹ ${searchrentvehicles[index]
                                              .rentPrice.toString()}',
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
                              );}else{return SizedBox();}}
                            ),
                          );
                        }),
                      ): SizedBox();
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
  @override
  void dispose() {

setState(() {
  rentCarSearchcontroller.clear();
});
    super.dispose();
  }
}
