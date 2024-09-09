part of 'order_buy_bloc.dart';

@immutable
sealed class OrderBuyEvent {}

class FeatchOrderBuyVehicles extends OrderBuyEvent {
  final String vehicleid;
  final String buyername;
  final String buyerphonenumber;
  final String buyeremail;
  final String buyeraddress;
  final double amount;

  FeatchOrderBuyVehicles(
      {required this.vehicleid,
        required this.buyername,
        required this.buyerphonenumber,
        required this.buyeremail,required this.buyeraddress,required this.amount,});
}