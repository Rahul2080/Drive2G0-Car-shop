part of 'search_rent_vehicles_bloc.dart';

@immutable
sealed class SearchRentVehiclesState {}

final class SearchRentVehiclesInitial extends SearchRentVehiclesState {}
class  SearchRentVehiclesBlocLoading extends  SearchRentVehiclesState {}
class  SearchRentVehiclesBlocLoaded extends  SearchRentVehiclesState {}
class  SearchRentVehiclesBlocError extends  SearchRentVehiclesState {}