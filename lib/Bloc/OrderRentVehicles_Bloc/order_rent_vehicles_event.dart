part of 'order_rent_vehicles_bloc.dart';

@immutable
sealed class OrderRentVehiclesEvent {}

class FeatchOrderRentVehicles extends OrderRentVehiclesEvent {
  final String vehicleid;

  final String pickeddate;
  final String returneddate;
  final String pickuplocationcontroller;
  final String returnlocationcontroller;
  final double amount;

  FeatchOrderRentVehicles({
    required this.vehicleid,

    required this.pickeddate,
    required this.returneddate,
    required this.pickuplocationcontroller,
    required this.returnlocationcontroller,
    required this.amount,
  });
}
