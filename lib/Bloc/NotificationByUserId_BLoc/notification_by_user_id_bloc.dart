import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/Api/api.dart';
import 'package:meta/meta.dart';

import '../../Repository/ModelClass/NotificationByUserIDModel.dart';

part 'notification_by_user_id_event.dart';
part 'notification_by_user_id_state.dart';

class NotificationByUserIdBloc extends Bloc<NotificationByUserIdEvent, NotificationByUserIdState> {
  late List<NotificationByUserIdModel> notificationbyuserid;
  UserApi userApi= UserApi();
  NotificationByUserIdBloc() : super(NotificationByUserIdInitial()) {
    on<FeatchNotificationByUserId>((event, emit) async{
      emit(NotificationByUserIdBLocLoading());

      try{
        notificationbyuserid=await userApi.getNotificationByUserId();
        emit(NotificationByUserIdBLocLoaded());
      }
catch(e)
{
  emit(NotificationByUserIdBLocError());
}


    });
  }
}
