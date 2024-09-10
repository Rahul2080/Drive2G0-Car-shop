part of 'my_order_buy_vehicles_bloc.dart';

@immutable
sealed class MyOrderBuyVehiclesState {}

final class MyOrderBuyVehiclesInitial extends MyOrderBuyVehiclesState {}
class MyOrderBuyVehiclesBlocLoading extends MyOrderBuyVehiclesState {}
class MyOrderBuyVehiclesBlocLoaded extends MyOrderBuyVehiclesState {}
class MyOrderBuyVehiclesBlocError extends MyOrderBuyVehiclesState {}