part of 'order_buy_bloc.dart';

@immutable
sealed class OrderBuyState {}

final class OrderBuyInitial extends OrderBuyState {}
class OrderBuyVehiclesBlocLoading extends  OrderBuyState {}
class OrderBuyVehiclesBlocLoaded extends  OrderBuyState {}
class OrderBuyVehiclesBlocError extends  OrderBuyState {}