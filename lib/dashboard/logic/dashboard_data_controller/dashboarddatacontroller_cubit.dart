import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';
import 'package:vehicle_tracker/config/sms_decoder.dart';
import 'package:vehicle_tracker/config/sms_decoder_enum.dart';
import 'package:vehicle_tracker/dashboard/logic/update_location/updatelocation_cubit.dart';
import 'package:vehicle_tracker/dashboard/logic/update_status/update_status_cubit.dart';

part 'dashboarddatacontroller_state.dart';

class DashboarddatacontrollerCubit extends Cubit<DashboarddatacontrollerState> {
  UpdatelocationCubit updatelocationCubit;
  UpdateStatusCubit updateStatusCubit;
  DashboarddatacontrollerCubit({
    required this.updatelocationCubit,
    required this.updateStatusCubit,
  }) : super(DashboarddatacontrollerInitial());

  Future<void> handleSMSList({required List<SmsMessage> smsList}) async {
    bool locationDatafound = false;
    bool statusDatafound = false;
    for (var message in smsList) {
      if (SMSDecoder.decodeSMS(sms: message.body ?? 'N/A') ==
              SmsDecoder.location &&
          !locationDatafound) {
        await updatelocationCubit.updateLocation(sms: message.body ?? 'N/A');
        locationDatafound = true;
      }
      if (SMSDecoder.decodeSMS(sms: message.body ?? 'N/A') ==
              SmsDecoder.checkStatus &&
          !statusDatafound) {
        await updateStatusCubit.updateStaus(sms: message.body ?? 'N/A');
        statusDatafound = true;
      }
    }
    if (!locationDatafound) {
      await updatelocationCubit.noLocationFound();
    }
    if (!statusDatafound) {
      await updateStatusCubit.noStatusFound();
    }
    return;
  }

  Future<void> handleSMS({required String sms}) async {
    final smsType = SMSDecoder.decodeSMS(sms: sms);
    switch (smsType) {
      case SmsDecoder.location:
        await updatelocationCubit.updateLocation(sms: sms);
        return;
      case SmsDecoder.checkStatus:
        await updateStatusCubit.updateStaus(sms: sms);
        return;
      default:
        return;
    }
  }
}
