part of 'search_rent_vehicles_bloc.dart';

@immutable
sealed class SearchRentVehiclesEvent {}
class FeatchSearchRentVehicles extends SearchRentVehiclesEvent {
  final String brandname;

  FeatchSearchRentVehicles ( {required this.brandname,});
}