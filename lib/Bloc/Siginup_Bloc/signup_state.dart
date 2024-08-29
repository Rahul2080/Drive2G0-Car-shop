part of 'signup_bloc.dart';

@immutable
sealed class SignupState {}

final class SignupInitial extends SignupState {}
class userBlocLoading extends  SignupState {}
class userBlocLoaded extends  SignupState {}
class userBlocError extends  SignupState {}