import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:drive2go/Repository/ModelClass/UserModel.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  late UserModel userModel=UserModel();
  UserApi userApi=UserApi();
  SignupBloc() : super(SignupInitial()) {
    on<FeatchUser>((event, emit) async{
      emit (userBlocLoading());
      try{ userModel=await userApi.getuser(event.name,event.email,event.phonenumber,event.password);
emit(userBlocLoaded());
      }
          catch(e){
        print("hi"+e.toString());
        emit (userBlocError());}
      // TODO: implement event handler
    });
  }
}
