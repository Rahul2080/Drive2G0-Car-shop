part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}
class FeatchLogin extends LoginEvent{
  final String email;
  final String password;
  FeatchLogin ( {required this.email,required this.password,});

}