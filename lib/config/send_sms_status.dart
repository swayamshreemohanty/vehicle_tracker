enum SendSMS {
  ignationOn,
  startEngine,
  ignationOff,
  checkStatus,
  fetchLocation,
}

extension SMSStatus on SendSMS {
  String sendStatusByString(SendSMS sendSMS) {
    switch (sendSMS) {
      case SendSMS.ignationOn:
        return 'ignation_on';
      case SendSMS.startEngine:
        return 'start_engine';
      case SendSMS.ignationOff:
        return 'ignation_off';
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
