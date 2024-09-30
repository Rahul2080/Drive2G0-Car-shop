part of 'notificatio_mark_read_bloc.dart';

@immutable
sealed class NotificatioMarkReadEvent {}
class FeatchNotificatioMarkRead extends  NotificatioMarkReadEvent {
final  String id;
FeatchNotificatioMarkRead({required this.id });

}