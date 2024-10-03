import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/AuthenticationModels/UserbyUserIdPasswordModel.dart';

part 'userby_user_id_forgot_password_event.dart';
part 'userby_user_id_forgot_password_state.dart';

class UserbyUserIdForgotPasswordBloc extends Bloc<UserbyUserIdForgotPasswordEvent, UserbyUserIdForgotPasswordState> {
  late UserbyUserIdPasswordModel userbyUserIdPasswordModel= UserbyUserIdPasswordModel();
  UserApi userApi =UserApi();
  UserbyUserIdForgotPasswordBloc() : super(UserbyUserIdForgotPasswordInitial()) {
    on<FeatchUserbyUserIdForgotPassword>((event, emit)async {
      emit(UserbyUserIdForgotPasswordBlocLoading());
      try{
        userbyUserIdPasswordModel = await userApi.getUserbyUseridForgotPasswod();
        emit(UserbyUserIdForgotPasswordBlocLoaded());

      }
          catch(e){emit(UserbyUserIdForgotPasswordBlocError());}



    });
  }
}
