import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:telephony/telephony.dart';

part 'sms_service_event.dart';
part 'sms_service_state.dart';

class SmsServiceBloc extends Bloc<SmsServiceEvent, SmsServiceState> {
  SmsServiceBloc() : super(SmsServiceInitial()) {
    on<SmsServiceEvent>((event, emit) async {
      if (event is SendSms) {
        await smsService.sendSms(
          to: "7609934272",
          message: "hello",
        );
      } else if (event is ListenToSms) {
      } else if (event is FetchSms) {
      } else {}
      // switch (event.runtimeType) {
      //   case ListenToSms:
      //     return;
      //   case SendSms:
      //   print(event)
      //     return;
      //   default:
      //     emit(SmsServiceInitial());
      //     return;
      // }
    });
  }
  final Telephony smsService = Telephony.instance;
}
