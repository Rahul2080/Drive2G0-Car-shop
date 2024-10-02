part of 'forgot_password_bloc.dart';

@immutable
sealed class ForgotPasswordEvent {}
class FeatchForgotPassword extends ForgotPasswordEvent {
  final String email;
  FeatchForgotPassword({ required this.email});

}