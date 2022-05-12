part of 'sms_service_bloc.dart';

@immutable
abstract class SmsServiceEvent {}

class ListenToSms extends SmsServiceEvent {}

class FetchSms extends SmsServiceEvent {
  final BuildContext context;

  FetchSms({required this.context});
}

class SendSms extends SmsServiceEvent {
  final String command;
  final BuildContext context;
  SendSms({
    required this.command,
    required this.context,
  });
}
