part of 'search_buy_vehicles_bloc.dart';

@immutable
sealed class SearchBuyVehiclesState {}

final class SearchBuyVehiclesInitial extends SearchBuyVehiclesState {}
class  SearchBuyVehiclesBlocLoading extends  SearchBuyVehiclesState {}
class  SearchBuyVehiclesBlocLoaded extends  SearchBuyVehiclesState {}
class  SearchBuyVehiclesBlocError extends  SearchBuyVehiclesState {}