import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/ShowSendMessageModel.dart';

part 'show_send_message_event.dart';

part 'show_send_message_state.dart';

class ShowSendMessageBloc
    extends Bloc<ShowSendMessageEvent, ShowSendMessageState> {
  late List<ShowSendMessageModel> showSendMessage;
  UserApi userApi = UserApi();

  ShowSendMessageBloc() : super(ShowSendMessageInitial()) {
    on<FeatchShowSendMessage>((event, emit) async {
      emit(ShowSendMessageBlocLoading());
      try {
        showSendMessage = await userApi.getShowSendMessage();
        emit(ShowSendMessageBlocLoaded());
      } catch (e) {
        emit(ShowSendMessageBlocError());
      }
    });
  }
}
