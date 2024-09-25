part of 'send_message_bloc.dart';

@immutable
sealed class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}
class SendMessageBlocLoading extends SendMessageState {}
class SendMessageBlocLoaded extends SendMessageState {}
class SendMessageBlocError extends SendMessageState {}