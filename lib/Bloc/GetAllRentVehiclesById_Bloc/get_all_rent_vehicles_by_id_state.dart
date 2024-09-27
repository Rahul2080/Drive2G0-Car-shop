part of 'get_all_rent_vehicles_by_id_bloc.dart';

@immutable
sealed class GetAllRentVehiclesByIdState {}

final class GetAllRentVehiclesByIdInitial extends GetAllRentVehiclesByIdState {}
class GetAllRentVehiclesByIdBlocLoading extends GetAllRentVehiclesByIdState {}
class GetAllRentVehiclesByIdBlocLoaded extends GetAllRentVehiclesByIdState {}
class GetAllRentVehiclesByIdBlocError extends GetAllRentVehiclesByIdState {}