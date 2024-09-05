part of 'buy_all_vehicles_bloc.dart';

@immutable
sealed class BuyAllVehiclesState {}

final class BuyAllVehiclesInitial extends BuyAllVehiclesState {}
class BuyAllVehiclesBlocLoading extends  BuyAllVehiclesState {}
class BuyAllVehiclesBlocLoaded extends  BuyAllVehiclesState {}
class BuyAllVehiclesBlocError extends  BuyAllVehiclesState {}