import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_tracker/model/location_model.dart';
part 'updatelocation_state.dart';

LocationModel _locationExtracter(String sms) {
  final regex = RegExp(r'latitude:\s*(.*)\,\s*longitude:\s*(.*)');
  final match = regex.firstMatch(sms);
  return LocationModel(
    latitude: double.parse(match?.group(1) ?? '20.5937'),
    longitude: double.parse(match?.group(2) ?? '78.9629'),
  );
}

class UpdatelocationCubit extends Cubit<UpdatelocationState> {
  UpdatelocationCubit() : super(UpdatelocationInitial());

  Future<void> updateLocation({required String sms}) async {
    emit(Loadinglocation());
    final location = await compute(_locationExtracter, sms); //separate isolate
    emit(LocationFetched(location: location));
    return;
  }

  Future<void> noLocationFound() async {
    emit(Loadinglocation());
    emit(NoLocationfound(error: "No location found!"));
    return;
  }
}