part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class FeatchEditProfile extends EditProfileEvent {
  final String name;
  final String email;
  final String oldpassword;
  final String newpassword;
  final String profileurl;

  FeatchEditProfile({
    required this.name,
    required this.email,
    required this.oldpassword,
    required this.newpassword,
    required this.profileurl,
  });
}
