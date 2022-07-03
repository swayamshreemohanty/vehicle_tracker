import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vehicle_tracker/config/send_sms_status.dart';
import 'package:vehicle_tracker/dashboard/logic/sms_service/sms_service_bloc.dart';

class ActionButtons extends StatelessWidget {
  const ActionButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Buttons(
              buttonName: 'Ignition On',
              onPressed: () {
                context.read<SmsServiceBloc>().add(
                    SendSms(command: SendSMS.ignitionOn, context: context));
              },
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Buttons(
              buttonName: 'Start Engine',
              onPressed: () {
                context.read<SmsServiceBloc>().add(
                    SendSms(command: SendSMS.startEngine, context: context));
              },
            ),
            Buttons(
              buttonName: 'Ignition Off',
              onPressed: () {
                context.read<SmsServiceBloc>().add(
                    SendSms(command: SendSMS.ignitionOff, context: context));
              },
            ),
            Buttons(
              buttonName: 'Status',
              onPressed: () {
                context.read<SmsServiceBloc>().add(
                    SendSms(command: SendSMS.checkStatus, context: context));
              },
            ),
          ],
        ),
      ],
    );
  }
}

class Buttons extends StatelessWidget {
  final String buttonName;
  final void Function()? onPressed;
  const Buttons({
    Key? key,
    required this.buttonName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonNameTextStyle = GoogleFonts.poppins(
        textStyle: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14.sp,
    ));
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.w),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 20.h),
          ),
          onPressed: onPressed,
          child: Text(
            buttonName,
            style: buttonNameTextStyle,
          ),
        ),
      ),
    );
  }
}
