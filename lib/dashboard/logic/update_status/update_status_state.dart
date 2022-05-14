part of 'update_status_cubit.dart';

@immutable
abstract class UpdateStatusState {}

class UpdateStatusInitial extends UpdateStatusState {}

class LoadingStatus extends UpdateStatusState {}

class NoStatusfound extends UpdateStatusState {
  final String error;
  NoStatusfound({required this.error});
}

class StatusFetched extends UpdateStatusState {
  final StatusModel status;
  StatusFetched({required this.status});
}
