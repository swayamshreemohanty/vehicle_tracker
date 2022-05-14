import 'package:vehicle_tracker/config/sms_decoder_enum.dart';

class SMSDecoder {
  static SmsDecoder decodeSMS({required String sms}) {
    if (sms.contains('your vehicle location')) {
      return SmsDecoder.location;
    } else if (sms.contains('your vehicle status')) {
      return SmsDecoder.checkStatus;
    } else {
      return SmsDecoder.startStop;
    }
  }
}