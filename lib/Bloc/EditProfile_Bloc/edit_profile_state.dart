part of 'edit_profile_bloc.dart';

@immutable
sealed class EditProfileState {}

final class EditProfileInitial extends EditProfileState {}
class EditProfileBlocLoading extends  EditProfileState {}
class EditProfileBlocLoaded extends  EditProfileState {}
class EditProfileBlocError extends  EditProfileState {}