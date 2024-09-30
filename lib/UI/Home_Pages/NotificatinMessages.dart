import 'package:drive2go/Bloc/NotificationByUserId_BLoc/notification_by_user_id_bloc.dart';
import 'package:drive2go/Bloc/NotificationReadMessage_Bloc/notificatio_mark_read_bloc.dart';
import 'package:drive2go/Repository/ModelClass/NotificationMarkReadModel.dart';
import 'package:drive2go/UI/BottomNavigation.dart';
import 'package:drive2go/UI/Car_Buy_Pages/CarBuy_Details.dart';
import 'package:drive2go/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../../Repository/ModelClass/NotificationByUserIDModel.dart';
import 'NotificationViewMarked.dart';
import 'car_Rent_details.dart';

class NotificatinMessages extends StatefulWidget {
  final List<String> recomcarplace;

  const NotificatinMessages({
    super.key,
    required this.recomcarplace,
  });

  @override
  State<NotificatinMessages> createState() => _NotificatinMessagesState();
}

class _NotificatinMessagesState extends State<NotificatinMessages> {
  String _currentAddress = '';
  String Buyvehicleplace = '';

  @override
  void initState() {
    BlocProvider.of<NotificationByUserIdBloc>(context)
        .add(FeatchNotificationByUserId());
    super.initState();
  }

  late List<NotificationByUserIdModel> notificationbyuserid;
  late NotificationMarkReadModel notificationMarkRead;

  _getrentVechileAddress(String lat, String long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      double.parse(lat),
      double.parse(long),
    );
    // Return the list of placemarks instead of a single placemark
    _currentAddress = placemarks[0].locality ?? "";
  }

  _getbuyVechileAddress(String lat, String long) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
      double.parse(lat),
      double.parse(long),
    );
    // Return the list of placemarks instead of a single placemark
    Buyvehicleplace = placemarks[1].locality ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => Bottomnavigation()));
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
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
                              return BlocListener<NotificationMarkReadBloc,
                                  NotificationMarkReadState>(
                                listener: (context, state) {
                                  if (state is NotificatioMarkReadBlocLoading) {
                                    print("siginloading");
                                  }
                                  if (state is NotificatioMarkReadBlocError) {
                                    print('error');
                                  }
                                  if (state is NotificatioMarkReadBlocLoaded) {
                                    BlocProvider.of<NotificationByUserIdBloc>(
                                            context)
                                        .add(FeatchNotificationByUserId());
                                    notificationMarkRead = BlocProvider.of<
                                            NotificationMarkReadBloc>(context)
                                        .notificatioMarkReadModel;
                                  }
                                },
                                child: GestureDetector(
                                  onTap: () {
                                    BlocProvider.of<NotificationMarkReadBloc>(
                                            context)
                                        .add(FeatchNotificatioMarkRead(
                                            id: notificationbyuserid[position]
                                                .id
                                                .toString()));

                                    if (notificationbyuserid[position]
                                                .buyVehicleId ==
                                            null &&
                                        notificationbyuserid[position]
                                                .rentVehicleId ==
                                            null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (_) =>
                                                  NotificationViewMarked(
                                                    tittle:
                                                        notificationbyuserid[
                                                                position]
                                                            .title
                                                            .toString(),
                                                    discription:
                                                        notificationbyuserid[
                                                                position]
                                                            .message
                                                            .toString(),
                                                  )));
                                    } else if (notificationbyuserid[position]
                                            .buyVehicleId ==
                                        null) {
                                      // print(
                                      //     'object rahul here ' + widget.carplace);
                                      _getrentVechileAddress(
                                          notificationbyuserid[position]
                                              .rentVehicleId!
                                              .location!
                                              .coordinates!
                                              .first
                                              .toString(),
                                          notificationbyuserid[position]
                                              .rentVehicleId!
                                              .location!
                                              .coordinates!
                                              .last
                                              .toString());
                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (_) => CarRentDetails(
                                            vehicleid:
                                                notificationbyuserid[position]
                                                    .rentVehicleId!
                                                    .id
                                                    .toString(),
                                            carplace: _currentAddress,
                                            recomcarplace: widget.recomcarplace,
                                            carname: notificationbyuserid[position].rentVehicleId!.brand.toString(),
                                            carcolor: notificationbyuserid[position].rentVehicleId!.vehicleColor.toString(),
                                            carprice: notificationbyuserid[position].rentVehicleId!.rentPrice.toString(),
                                            carimage: notificationbyuserid[position].rentVehicleId!.photos.toString(),
                                          ),
                                        ),
                                      );
                                    } else {
                                      _getbuyVechileAddress(
                                          notificationbyuserid[position]
                                              .buyVehicleId!
                                              .location!
                                              .coordinates!
                                              .first
                                              .toString(),
                                          notificationbyuserid[position]
                                              .buyVehicleId!
                                              .location!
                                              .coordinates!
                                              .last
                                              .toString());

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
                                              carplace: Buyvehicleplace,
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
                                        ? SizedBox(
                                            width: 60.w,
                                            height: 60.h,
                                            child: Image.asset(
                                              'assets/notificationViewimage.png',fit: BoxFit.cover,
                                            ))
                                        : Container(
                                            width: 60.w,
                                            height: 60.h,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    notificationbyuserid[position]
                                                                .buyVehicleId ==
                                                            null
                                                        ? notificationbyuserid[
                                                                position]
                                                            .rentVehicleId!
                                                            .photos![0]
                                                        : notificationbyuserid[
                                                                position]
                                                            .buyVehicleId!
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
                                          fontSize: 16.sp,
                                          fontFamily: 'sf pro display',
                                          fontWeight: FontWeight.w600,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
