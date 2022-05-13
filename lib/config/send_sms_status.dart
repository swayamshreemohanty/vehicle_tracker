enum SendSMS {
  start,
  stop,
  checkStatus,
  fetchLocation,
}

extension SMSStatus on SendSMS {
  String sendStatusByString(SendSMS sendSMS) {
    switch (sendSMS) {
      case SendSMS.start:
        return 'start';
      case SendSMS.stop:
        return 'stop';
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
