import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:drive2go/Repository/ModelClass/AuthenticationModels/UserModel.dart';
import 'package:meta/meta.dart';

import '../../ToastMessage.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  late UserModel userModel;
  UserApi userApi=UserApi();
  SignupBloc() : super(SignupInitial()) {
    on<FeatchUser>((event, emit) async{
      emit (userBlocLoading());
      try{ userModel=await userApi.getuser(event.name,event.email,event.phonenumber,event.password);
emit(userBlocLoaded());
      }
          catch(e){
            ToastMessage()
                .toastmessage(message:e.toString());
        emit (userBlocError());}
      // TODO: implement event handler
    });
  }
}
