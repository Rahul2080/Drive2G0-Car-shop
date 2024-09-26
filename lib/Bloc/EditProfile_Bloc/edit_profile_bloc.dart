import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:drive2go/Repository/ModelClass/EditProfileModel.dart';
import 'package:meta/meta.dart';

part 'edit_profile_event.dart';

part 'edit_profile_state.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  late EditProfileModel editProfileModel;
  UserApi userApi = UserApi();

  EditProfileBloc() : super(EditProfileInitial()) {
    on<FeatchEditProfile>((event, emit) async {
      emit(EditProfileBlocLoading());
      try {
        if(event.forProfile==true){
        editProfileModel = await userApi.getMyEditProfilePhoto(event.name??"", event.email??"",
            event.oldpassword??"", event.newpassword??"", event.profileurl!);
        }
        else{
          editProfileModel = await userApi.getMyEditProfile(event.name??"",
              event.oldpassword??"", event.newpassword??"");
        }
        emit(EditProfileBlocLoaded() );
      } catch (e) {
        print( 'photo error '+e.toString());
        emit(EditProfileBlocError());
      }
    });
  }
}