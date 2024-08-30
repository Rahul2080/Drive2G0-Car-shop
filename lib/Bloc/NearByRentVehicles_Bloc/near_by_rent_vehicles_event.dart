part of 'near_by_rent_vehicles_bloc.dart';

@immutable
sealed class NearByRentVehiclesEvent {}
class FeatchNearByCarVehicles extends NearByRentVehiclesEvent {
final String lat;
final String long;
  FeatchNearByCarVehicles( {required this.lat,required this.long, });
}