import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:drive2go/Repository/ModelClass/AuthenticationModels/ForgotPasswordModel.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  late ForgotPasswordModel forgotPasswordModel;
  UserApi userApi=UserApi();
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<FeatchForgotPassword>((event, emit) async{

      emit(ForgotPasswordBlocLoading());
      try{
        forgotPasswordModel=await userApi.getForgotPasswod(event.email);
        emit(ForgotPasswordBlocLoaded());
      }
          catch(e){
        emit(ForgotPasswordBlocError());
          }



    });
  }
}
