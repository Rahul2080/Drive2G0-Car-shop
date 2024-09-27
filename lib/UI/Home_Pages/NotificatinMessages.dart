import 'package:drive2go/Bloc/NotificationByUserId_BLoc/notification_by_user_id_bloc.dart';
import 'package:drive2go/UI/BottomNavigation.dart';
import 'package:drive2go/UI/Car_Buy_Pages/CarBuy_Details.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Repository/ModelClass/NotificationByUserIDModel.dart';
import 'NotificationViewMarked.dart';
import 'car_Rent_details.dart';

class NotificatinMessages extends StatefulWidget {
  final List<String> recomcarplace;
  final String carplace;

  const NotificatinMessages(
      {super.key, required this.recomcarplace, required this.carplace});

  @override
  State<NotificatinMessages> createState() => _NotificatinMessagesState();
}

class _NotificatinMessagesState extends State<NotificatinMessages> {
  @override
  void initState() {
    BlocProvider.of<NotificationByUserIdBloc>(context)
        .add(FeatchNotificationByUserId());
    _getCurrentLocation();
    super.initState();
  }

  GoogleMapController? _mapController;
  Position? _currentPosition;
  LatLng _initialPosition = LatLng(37.42796133580664, -122.085749655962);
  String? _currentAddress;
  Future<void> _getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        _currentPosition = position;
        _initialPosition = LatLng(
          position.latitude,
          position.longitude,
        );
        _mapController?.animateCamera(
          CameraUpdate.newLatLng(_initialPosition),
        );
      });

      await _getAddressFromLatLng(_currentPosition!).then((onValue) {

      });
    } catch (e) {
      // Handle error
      print(e);
    }
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      Placemark place = placemarks[0];

      setState(() {
        _currentAddress = " ${place.locality}, ${place.administrativeArea}";
      });

      print("Address: $_currentAddress");
    } catch (e) {
      print(e);
    }
  }

  late List<NotificationByUserIdModel> notificationbyuserid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Bottomnavigation()));},
            child: Icon(Icons.arrow_back,color: Colors.white,)),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child:
              BlocBuilder<NotificationByUserIdBloc, NotificationByUserIdState>(
                  builder: (context, state) {
            if (state is NotificationByUserIdBLocLoading) {
              print("loading");
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is NotificationByUserIdBLocError) {
              print("error");
              return Center(
                child: Text(
                  "Error",
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
            if (state is NotificationByUserIdBLocLoaded) {
              notificationbyuserid =
                  BlocProvider.of<NotificationByUserIdBloc>(context)
                      .notificationbyuserid;

              return notificationbyuserid.length == 0
                  ? Container(
                      child: Icon(
                        Icons.emoji_emotions_outlined,
                        size: 100.sp,
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.h),
                        SizedBox(
                          width: 400.w,
                          height: 900.h,
                          child: ListView.separated(
                            itemCount: notificationbyuserid.length,
                            itemBuilder: (context, position) {
                              return GestureDetector(
                                onTap: () {
                                  if (notificationbyuserid[position]
                                              .buyVehicleId ==
                                          null &&
                                      notificationbyuserid[position]
                                              .rentVehicleId ==
                                          null) {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (_) =>
                                                NotificationViewMarked()));
                                  } else if (notificationbyuserid[position]
                                          .buyVehicleId ==
                                      null) {
                                    Navigator.of(context)
                                        .push(MaterialPageRoute(
                                            builder: (_) => CarRentDetails(
                                                  vehicleid:
                                                      notificationbyuserid[
                                                              position]
                                                          .rentVehicleId!
                                                          .id
                                                          .toString(),
                                                  carplace: '',
                                                  recomcarplace:
                                                      widget.recomcarplace,
                                                )));
                                  } else {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => CarbuyDetails(
                                            carimage: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .photos!
                                                .toList(),
                                            carname: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .brand
                                                .toString(),
                                            ratting: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .rating
                                                .toString(),
                                            tanktype: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .fuelType
                                                .toString(),
                                            geartype: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .gearType
                                                .toString(),
                                            seat: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .noOfSeats
                                                .toString(),
                                            door: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .noOfDoors
                                                .toString(),
                                            Ownerimge: notificationbyuserid[position]
                                                .buyVehicleId!
                                                .ownerProfilePhoto
                                                .toString(),
                                            Ownername:
                                                notificationbyuserid[position]
                                                    .buyVehicleId!
                                                    .ownerName
                                                    .toString(),
                                            Ownerplace:
                                                notificationbyuserid[position]
                                                    .buyVehicleId!
                                                    .ownerPlace
                                                    .toString(),
                                            carplace: '',
                                            recomcarplaces: widget.recomcarplace,
                                            price: notificationbyuserid[position].buyVehicleId!.rentPrice.toString(),
                                            id: notificationbyuserid[position].buyVehicleId!.id.toString(),
                                            ownernumber: notificationbyuserid[position].buyVehicleId!.ownerPhoneNumber.toString())));
                                  }
                                },
                                child: ListTile(
                                  leading: notificationbyuserid[position]
                                                  .rentVehicleId ==
                                              null &&
                                          notificationbyuserid[position]
                                                  .buyVehicleId ==
                                              null
                                      ? Container(
                                          width: 60.w,
                                          height: 60.h,
                                          child: Icon(
                                            Icons.ac_unit,
                                            size: 50.sp,
                                            color: Colors.grey,
                                          ))
                                      : Container(
                                          width: 60.w,
                                          height: 60.h,
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: NetworkImage(
                                                  notificationbyuserid[position]
                                                      .rentVehicleId!
                                                      .photos![0],
                                                ),
                                                fit: BoxFit.cover,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5.r)),
                                        ),
                                  title: SizedBox(
                                    width: 90.w,
                                    height: 30.h,
                                    child: Text(
                                      notificationbyuserid[position]
                                          .title
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Color(0xFFF7F5F2),
                                        fontSize: 22.sp,
                                        fontFamily: 'sf pro display',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  subtitle: SizedBox(
                                    width: 90.w,
                                    height: 30.h,
                                    child: Text(
                                      notificationbyuserid[position]
                                          .message
                                          .toString(),
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: Color(0xFFF7F5F2),
                                        fontSize: 22.sp,
                                        fontFamily: 'sf pro display',
                                        fontWeight: FontWeight.w600,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(
                                height: 5.h,
                              );
                            },
                          ),
                        ),
                      ],
                    );
            } else {
              return SizedBox();
            }
          }),
        ),
      ),
    );
  }
}
