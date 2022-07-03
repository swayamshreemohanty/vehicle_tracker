enum SendSMS {
   ignitionOn,
  startEngine,
  ignitionOff,
  checkStatus,
  fetchLocation,
}

extension SMSStatus on SendSMS {
  String sendStatusByString(SendSMS sendSMS) {
    switch (sendSMS) {
      case SendSMS. ignitionOn:
        return 'ignition_on';
      case SendSMS.startEngine:
        return 'start_engine';
      case SendSMS. ignitionOff:
        return 'ignition_off';
      case SendSMS.checkStatus:
        return 'checkstatus';
      case SendSMS.fetchLocation:
        return 'fetchlocation';
      default:
        return 'error';
    }
  }

  String convertToString() => sendStatusByString(this);
}
