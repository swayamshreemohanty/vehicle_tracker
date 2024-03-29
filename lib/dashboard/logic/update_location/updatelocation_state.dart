part of 'updatelocation_cubit.dart';

@immutable
abstract class UpdatelocationState {}

class UpdatelocationInitial extends UpdatelocationState {}

class Loadinglocation extends UpdatelocationState {}

class NoLocationfound extends UpdatelocationState {
  final String error;
  NoLocationfound({required this.error});
}

class LocationFetched extends UpdatelocationState {
  final LocationModel location;

  LocationFetched({required this.location});
}
