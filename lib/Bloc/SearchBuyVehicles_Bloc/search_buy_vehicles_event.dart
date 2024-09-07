part of 'search_buy_vehicles_bloc.dart';

@immutable
sealed class SearchBuyVehiclesEvent {}
class FeatchSearchBuyVehicles extends SearchBuyVehiclesEvent {

  final String brandname;
  FeatchSearchBuyVehicles( {required this.brandname,});
}