import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicle_tracker/model/status_model.dart';
part 'update_status_state.dart';

StatusModel _statusExtracter(String sms) {
  final regex = RegExp(r'condition:\s*(.*)\,\s*temperature:\s*(.*)');
  final match = regex.firstMatch(sms);
  return StatusModel(
    condition: match?.group(1) ?? 'N/A',
    temperature: match?.group(2) ?? 'N/A',
  );
}

class UpdateStatusCubit extends Cubit<UpdateStatusState> {
  UpdateStatusCubit() : super(UpdateStatusInitial());
  Future<void> updateStaus({required String sms}) async {
    emit(LoadingStatus());
    final status = await compute(_statusExtracter, sms); //separate isolate
    emit(StatusFetched(status: status));
    return;
  }

  Future<void> noStatusFound() async {
    emit(LoadingStatus());
    emit(NoStatusfound(error: "N/A"));
    return;
  }
}
