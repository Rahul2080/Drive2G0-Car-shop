import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/SendMessageModel.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  late SendMessageModel sendMessageModel;
  UserApi userApi=UserApi();
  SendMessageBloc() : super(SendMessageInitial()) {
    on<FeatchSendMeassage>((event, emit)async {

      emit(SendMessageBlocLoading() );
      try{
        sendMessageModel=await userApi.getMySendMessage(event.Description);
        emit(SendMessageBlocLoaded());

      }
          catch(e){
        emit(SendMessageBlocError());
          }


    });
  }
}
