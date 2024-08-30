part of 'all_rent_vehicles_bloc.dart';

@immutable
sealed class AllRentVehiclesState {}

final class AllRentVehiclesInitial extends AllRentVehiclesState {}
class AllRentVehiclesBlocLoading extends  AllRentVehiclesState {}
class AllRentVehiclesBlocLoaded extends  AllRentVehiclesState {}
class AllRentVehiclesBlocError extends  AllRentVehiclesState {}