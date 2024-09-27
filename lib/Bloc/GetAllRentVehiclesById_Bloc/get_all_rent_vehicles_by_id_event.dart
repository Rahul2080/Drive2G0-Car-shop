part of 'get_all_rent_vehicles_by_id_bloc.dart';

@immutable
sealed class GetAllRentVehiclesByIdEvent {}
class FeatchGetAllRentVehiclesById extends GetAllRentVehiclesByIdEvent {
  final String vehicleId;
  FeatchGetAllRentVehiclesById ({required this.vehicleId });
}