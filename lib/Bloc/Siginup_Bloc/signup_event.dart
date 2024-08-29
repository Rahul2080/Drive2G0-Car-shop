part of 'signup_bloc.dart';

@immutable
sealed class SignupEvent {}
class FeatchUser extends SignupEvent{
  final String name;
  final String email;
  final String phonenumber;
  final String password;
  FeatchUser({ required this.name,required this.email,required this.phonenumber,required this.password, });
}
