part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordState {}

final class ForgotPasswordInitial extends ForgotPasswordState {}
class ForgotPasswordBlocLoading extends ForgotPasswordState {}
class ForgotPasswordBlocLoaded extends ForgotPasswordState {}
class ForgotPasswordBlocError extends ForgotPasswordState {}