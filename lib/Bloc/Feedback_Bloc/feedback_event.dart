part of 'feedback_bloc.dart';

@immutable
sealed class FeedbackEvent {}
class FeatchFeedback extends  FeedbackEvent {

  final String comment;

  FeatchFeedback ( {required this.comment});


}