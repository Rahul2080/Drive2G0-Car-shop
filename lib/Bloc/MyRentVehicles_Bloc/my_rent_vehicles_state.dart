part of 'my_rent_vehicles_bloc.dart';

@immutable
sealed class MyRentVehiclesState {}

final class MyRentVehiclesInitial extends MyRentVehiclesState {}
class MyRentVehiclesBlocLoading extends  MyRentVehiclesState {}
class MyRentVehiclesBlocLoaded extends  MyRentVehiclesState {}
class MyRentVehiclesBlocError extends  MyRentVehiclesState {}