part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileEvent {}

class FeatchEditProfile extends EditProfileEvent {
  final String? name;
  final String? email;
  final String ?oldpassword;
  final String? newpassword;
  final File?  profileurl;
  final bool forProfile;

  FeatchEditProfile({
     this.name,
     this.email,
     this.oldpassword,
     this.newpassword,
     this.profileurl,
    required this.forProfile
  });
}