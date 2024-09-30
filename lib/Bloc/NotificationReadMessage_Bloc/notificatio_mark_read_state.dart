part of 'notificatio_mark_read_bloc.dart';

@immutable
sealed class NotificationMarkReadState {}

final class NotificatioMarkReadInitial extends NotificationMarkReadState {}
class NotificatioMarkReadBlocLoading extends NotificationMarkReadState {}
class NotificatioMarkReadBlocLoaded extends NotificationMarkReadState {}
class NotificatioMarkReadBlocError extends NotificationMarkReadState {}