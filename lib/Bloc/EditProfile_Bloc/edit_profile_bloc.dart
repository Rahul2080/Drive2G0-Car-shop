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
        editProfileModel = await userApi.getMyEditProfile(event.name, event.email,
            event.oldpassword, event.newpassword, event.profileurl);
        emit(EditProfileBlocLoaded() );
      } catch (e) {
        emit(EditProfileBlocError());
      }
    });
  }
}
