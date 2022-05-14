import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';
import 'package:vehicle_tracker/config/env.dart';
import 'package:vehicle_tracker/config/send_sms_status.dart';
import 'package:vehicle_tracker/dashboard/logic/dashboard_data_controller/dashboarddatacontroller_cubit.dart';
import 'package:vehicle_tracker/utility/show_snak_bar.dart';
part 'sms_service_event.dart';
part 'sms_service_state.dart';

class SmsServiceBloc extends Bloc<SmsServiceEvent, SmsServiceState> {
  final DashboarddatacontrollerCubit dashboarddatacontrollerCubit;
  SmsServiceBloc({
    required this.dashboarddatacontrollerCubit,
  }) : super(SmsServiceInitial()) {
    on<SmsServiceEvent>((event, emit) async {
      if (event is SendSms) {
        try {
          late SmsSendStatusListener listener;
          void showRequestStatus(SendStatus status) {
            switch (status) {
              case SendStatus.SENT:
                ShowSnackBar.showSnackBar(event.context, ShowSnackBar.sent);
                return;
              case SendStatus.DELIVERED:
                ShowSnackBar.showSnackBar(
                    event.context, ShowSnackBar.delivered);
                return;
              default:
                ShowSnackBar.showSnackBar(event.context, ShowSnackBar.failed);
                return;
            }
          }

          final permissionsGranted =
              await smsService.requestPhoneAndSmsPermissions ?? false;

          if (permissionsGranted) {
            listener = (SendStatus status) {
              showRequestStatus(status);
            };

            await smsService.sendSms(
              to: hostPhoneNumber,
              message: event.command.convertToString(),
              statusListener: listener,
            );
          }
          return;
        } catch (e) {
          if (e is PlatformException) {
            ShowSnackBar.showSnackBar(
              event.context,
              e.message ?? "Error occured.",
            );
          } else {
            ShowSnackBar.showSnackBar(event.context, 'Something went wrong.');
          }
          return;
        }
      } else if (event is ListenToSms) {
        smsService.listenIncomingSms(
          listenInBackground: false,
          onNewMessage: (SmsMessage message) async {
            await dashboarddatacontrollerCubit.handleSMS(
              sms: message.body ?? 'N/A',
            );
          },
        );
        return;
      } else if (event is FetchSms) {
        try {
          final permissionsGranted =
              await smsService.requestPhoneAndSmsPermissions ?? false;
          if (permissionsGranted) {
            List<SmsMessage> smsList = await smsService.getInboxSms(
              columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
              filter:
                  SmsFilter.where(SmsColumn.ADDRESS).equals(hostPhoneNumber),
              sortOrder: [
                OrderBy(SmsColumn.ID, sort: Sort.DESC),
              ],
            );
            await dashboarddatacontrollerCubit.handleSMSList(smsList: smsList);
          }
          return;
        } catch (e) {
          if (e is PlatformException) {
            dashboarddatacontrollerCubit.handleSMSList(smsList: []);
            ShowSnackBar.showSnackBar(
              event.context,
              e.message ?? "Error occured.",
            );
          } else {
            ShowSnackBar.showSnackBar(event.context, 'Something went wrong.');
          }
          return;
        }
      }
    });
  }
  final Telephony smsService = Telephony.instance;
}
