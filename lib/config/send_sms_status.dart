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
        return 'checkStatus';
      case SendSMS.fetchLocation:
        return 'fetchLocation';
      default:
        return 'error';
    }
  }

  String convertToString() => sendStatusByString(this);
}
