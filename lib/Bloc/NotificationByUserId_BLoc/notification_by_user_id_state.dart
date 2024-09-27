part of 'notification_by_user_id_bloc.dart';

@immutable
sealed class NotificationByUserIdState {}

final class NotificationByUserIdInitial extends NotificationByUserIdState {}
class NotificationByUserIdBLocLoading extends NotificationByUserIdState {}
class NotificationByUserIdBLocLoaded extends NotificationByUserIdState {}
class NotificationByUserIdBLocError extends NotificationByUserIdState {}