import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:drive2go/Repository/ModelClass/LoginModel.dart';
import 'package:meta/meta.dart';

import '../../ToastMessage.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  late LoginModel loginModel=LoginModel();
  UserApi userApi=UserApi();
  LoginBloc() : super(LoginInitial()) {
    on<FeatchLogin>((event, emit)async {
      emit(LoginBlocLoading());
      try{
        loginModel =await userApi.getLogin(event.email, event.password,event.fcmToken);
        emit(LoginBlocLoaded());
      }
          catch(e){
        emit(LoginBlocError());
        ToastMessage()
            .toastmessage(message:e.toString());

          }




    });
  }
}
