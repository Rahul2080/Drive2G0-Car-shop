import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:drive2go/Repository/ModelClass/ProfileModel.dart';
import 'package:meta/meta.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  late ProfileModel profileModel;
  UserApi userApi = UserApi();
  ProfileBloc() : super(ProfileInitial()) {
    on<FeatchProfile>((event, emit) async{
      emit( ProfileBlocLoading());
      try{
        profileModel= await userApi.getMyProfile();
        emit(ProfileBlocLoaded());
      }
          catch(e){
        emit(ProfileBlocError());
          }

    });
  }
}
