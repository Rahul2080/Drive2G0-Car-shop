part of 'near_by_rent_vehicles_bloc.dart';

@immutable
sealed class NearByRentVehiclesState {}

final class NearByRentVehiclesInitial extends NearByRentVehiclesState {}
class NearByRentVehiclesBlocLoading extends  NearByRentVehiclesState {}
class NearByRentVehiclesBlocLoaded extends  NearByRentVehiclesState {}
class NearByRentVehiclesBlocError extends  NearByRentVehiclesState {}