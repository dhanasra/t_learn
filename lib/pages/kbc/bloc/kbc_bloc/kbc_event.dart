part of 'kbc_bloc.dart';

@immutable
abstract class KbcEvent {}

class GetReady extends KbcEvent{}

class LeaveKbc extends KbcEvent{}

class StopTimer extends KbcEvent{}