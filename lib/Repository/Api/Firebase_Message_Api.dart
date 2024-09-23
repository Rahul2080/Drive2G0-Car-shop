import 'package:drive2go/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class  FirebaseMessageApi{


final firebasemessageing=FirebaseMessaging.instance;

Future<void> Notifications() async{
 await firebasemessageing.requestPermission();
 final fcmToken=await firebasemessageing.getToken();

 print('Token : $fcmToken ');
 Pushnotification();
}
void handlemessage( RemoteMessage? message){

 if(message==null) return;

 Navigatorkey.currentState?.pushNamed("/notification_screen",arguments: message);

}
Future Pushnotification()async{
 FirebaseMessaging.instance.getInitialMessage().then(handlemessage);

 FirebaseMessaging.onMessageOpenedApp.listen(handlemessage);
}

}