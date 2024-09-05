part of 'buy_near_vehicles_bloc.dart';

@immutable
sealed class BuyNearVehiclesState {}

final class BuyNearVehiclesInitial extends BuyNearVehiclesState {}
class BuyNearVehiclesBlocLoading extends  BuyNearVehiclesState {}
class BuyNearVehiclesBlocLoaded extends  BuyNearVehiclesState {}
class BuyNearVehiclesBlocError extends  BuyNearVehiclesState {}