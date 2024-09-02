part of 'order_rent_vehicles_bloc.dart';

@immutable
sealed class OrderRentVehiclesState {}

final class OrderRentVehiclesInitial extends OrderRentVehiclesState {}
class OrderRentVehiclesBlocLoading extends  OrderRentVehiclesState {}
class OrderRentVehiclesBlocLoaded extends  OrderRentVehiclesState {}
class OrderRentVehiclesBlocError extends  OrderRentVehiclesState {}