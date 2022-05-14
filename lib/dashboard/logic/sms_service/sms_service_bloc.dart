import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telephony/telephony.dart';
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
        late SmsSendStatusListener listener;
        try {
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
              await smsService.requestPhoneAndSmsPermissions;

          if (permissionsGranted ?? false) {
            listener = (SendStatus status) {
              showRequestStatus(status);
            };

            await smsService.sendSms(
              to: "7609934272",
              message: event.command.convertToString(),
              statusListener: listener,
            );
          }
        } catch (e) {
          if (e is PlatformException) {
            ShowSnackBar.showSnackBar(
              event.context,
              e.message ?? "Error occured.",
            );
          } else {
            ShowSnackBar.showSnackBar(event.context, 'Something went wrong.');
          }
        }
        return;
      } else if (event is ListenToSms) {
        smsService.listenIncomingSms(
          onNewMessage: (SmsMessage message) async {
            await dashboarddatacontrollerCubit.handleSMS(
              sms: message.body ?? 'N/A',
            );
          },
          listenInBackground: true,
          onBackgroundMessage: backgrounMessageHandler,
        );
        return;
      } else if (event is FetchSms) {
        try {
          final permissionsGranted =
              await smsService.requestPhoneAndSmsPermissions;
          if (permissionsGranted ?? false) {
            List<SmsMessage> smsList = await smsService.getInboxSms(
              columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
              filter:
                  SmsFilter.where(SmsColumn.ADDRESS).equals("+917609934272"),
              sortOrder: [
                OrderBy(SmsColumn.BODY, sort: Sort.DESC),
              ],
            );
            await dashboarddatacontrollerCubit.handleSMSList(smsList: smsList);
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
        }
      }
    });
  }
  final Telephony smsService = Telephony.instance;

  static backgrounMessageHandler(SmsMessage message) async {
    //Handle background message
    print("************Background msg received**********");
    // dashboarddatacontrollerCubit.handleSMS(sms: message.body ?? 'N/A');
  }
}