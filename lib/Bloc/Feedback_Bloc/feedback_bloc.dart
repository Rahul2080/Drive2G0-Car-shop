import 'package:bloc/bloc.dart';
import 'package:drive2go/Repository/ModelClass/ProfileModels/FeedbackModel/FeedbackModel.dart';
import 'package:meta/meta.dart';

import '../../Repository/Api/api.dart';

part 'feedback_event.dart';

part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  late FeedbackModel feedbackModel ;
  UserApi userApi = UserApi();

  FeedbackBloc() : super(FeedbackInitial()) {
    on<FeatchFeedback>((event, emit) async {
      emit(FeedbackBlocLoading());
      try {
        feedbackModel = await userApi.getMyFeedback(event.comment);
        emit(FeedbackBlocLoaded());
      } catch (e) {
        emit(FeedbackBlocError());
      }
    });
  }
}
