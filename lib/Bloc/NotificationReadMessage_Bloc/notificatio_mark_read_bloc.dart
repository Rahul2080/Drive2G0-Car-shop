import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/NotificationModels/NotificationMarkReadModel.dart';

part 'notificatio_mark_read_event.dart';
part 'notificatio_mark_read_state.dart';

class NotificationMarkReadBloc extends Bloc<NotificatioMarkReadEvent, NotificationMarkReadState> {
  late NotificationMarkReadModel notificatioMarkReadModel =NotificationMarkReadModel();
  UserApi userApi =UserApi();
  NotificationMarkReadBloc() : super(NotificatioMarkReadInitial()) {
    on<FeatchNotificatioMarkRead>((event, emit) async{
emit(NotificatioMarkReadBlocLoading() );
try{
  notificatioMarkReadModel =await userApi.getMyReadMessage(event.id);
  emit(NotificatioMarkReadBlocLoaded());

}
    catch(e){

  emit(NotificatioMarkReadBlocError());
    }

    });
  }
}
