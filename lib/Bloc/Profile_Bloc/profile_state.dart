part of 'profile_bloc.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
class ProfileBlocLoading extends ProfileState {}
class ProfileBlocLoaded extends ProfileState {}
class ProfileBlocError extends ProfileState {}