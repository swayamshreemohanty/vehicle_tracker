import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:telephony/telephony.dart';
import 'package:vehicle_tracker/config/sms_decoder.dart';
import 'package:vehicle_tracker/config/sms_decoder_enum.dart';
import 'package:vehicle_tracker/dashboard/logic/update_location/updatelocation_cubit.dart';

part 'dashboarddatacontroller_state.dart';

class DashboarddatacontrollerCubit extends Cubit<DashboarddatacontrollerState> {
  UpdatelocationCubit updatelocationCubit;
  DashboarddatacontrollerCubit({
    required this.updatelocationCubit,
  }) : super(DashboarddatacontrollerInitial());

  Future<void> handleSMSList({required List<SmsMessage> smsList}) async {
    bool locationDatafound = false;
    for (var message in smsList) {
      if (SMSDecoder.decodeSMS(sms: message.body ?? 'N/A') ==
              SmsDecoder.location &&
          !locationDatafound) {
        await updatelocationCubit.updateLocation(sms: message.body ?? 'N/A');
        locationDatafound = true;
      }
    }
    if (!locationDatafound) {
      await updatelocationCubit.noLocationFound();
    }
    return;
  }

  Future<void> handleSMS({required String sms}) async {
    final smsType = SMSDecoder.decodeSMS(sms: sms);
    switch (smsType) {
      case SmsDecoder.location:
        await updatelocationCubit.updateLocation(sms: sms);
        return;
      default:
        return;
    }
  }
}
