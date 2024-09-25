part of 'send_message_bloc.dart';

@immutable
sealed class SendMessageEvent {}
class FeatchSendMeassage extends SendMessageEvent {
  final String Description;

  FeatchSendMeassage({required this.Description});

}
