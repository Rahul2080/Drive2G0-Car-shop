part of 'buy_near_vehicles_bloc.dart';

@immutable
sealed class BuyNearVehiclesEvent {}
class FeatchBuyNearVehicles extends BuyNearVehiclesEvent {
  final String lat;
  final String long;
  FeatchBuyNearVehicles(  { required this.lat, required this.long, });
}