part of 'show_send_message_bloc.dart';

@immutable
sealed class ShowSendMessageState {}

final class ShowSendMessageInitial extends ShowSendMessageState {}
class ShowSendMessageBlocLoading extends ShowSendMessageState {}
class ShowSendMessageBlocLoaded extends ShowSendMessageState {}
class ShowSendMessageBlocError extends ShowSendMessageState {}