part of 'kbc_bloc.dart';

@immutable
abstract class KbcState {}

class KbcInitial extends KbcState {}

class KbcLoading extends KbcState {}

class KbcReady extends KbcState {
  final List<Question> questions;

  KbcReady({required this.questions});
}

class KbcLeaving extends KbcState {}

class KbcFinish extends KbcState {}

class TimerStopped extends KbcState {}